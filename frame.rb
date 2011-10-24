#!/usr/local/bin/ruby -Ku

# Template Method
# これがかなり重要
class Frame
  include Observable
  attr_accessor :fields, :players

  def initialize(fields=nil, players=nil)
    set_member(fields, players)
  end

  def set_member(fields, players)
    @fields = fields
    @players = players
  end

  def next_frame
    @fields.each{|obj|obj.next_frame}
    @players.each{|obj|obj.next_frame}
    show
  end

  def show
    changed
    notify_observers(self)
    # ObjectSpace.garbage_collect
  end

  def safe_show
    catch(:exit) {show}
  end

  def show_loop(&pblock)
    changed
    catch(:exit) {
      notify_observers(self)
      loop{
        pblock.call if pblock
      }
    }
  end

  def start(fps=0, &pblock)
    catch(:exit) {
      VSyncWait.time_out(fps){
        next_frame
        pblock.call if pblock
      }
    }
  end
end

# リプレイ情報をファイルに保存する
module MementSaveableMethods
  attr_reader :recfile          # ファイル名は自動的に決まる

  def to_marshal_binary
    require "etc"
    Marshal.dump(:seginfo => @seginfo, :seginfo1 => @seginfo1, :seginfo2 => @seginfo2, :time => Time.now, :user => Etc.getlogin)
  end
end

module FrameClassMethods
  # 再生(自分で操作する必要がある)
  def replay1(dump)
    new(*Marshal.load(dump))
  end

  def replay_with_input(marshal1, input_classes)
    field1, players1 = Marshal.load(marshal1)
    players1.each_with_index{|e,i|
      e.input = input_classes[i].new
    }
    new(field1, players1)
  end

  # リプレイ。marshal1 から marshal2 の間をリプレイする。
  def replay_a_to_b(marshal1, marshal2)
    field1, players1 = Marshal.load(marshal1)
    field2, players2 = Marshal.load(marshal2)
    players1.each_with_index{|e,i|
      e.input = TextInputUnit.new(players2[i].input.history[e.input.history.size..-1])
    }
    new(field1, players1)
  end
end

Frame.extend(FrameClassMethods)

# ループさせるのに必要
module MementControlMethods
  attr_reader :mement_stack
  def create_mement
    Marshal.dump([@fields, @players])
  end

  def restore_mement(mement)
    @fields, @players = Marshal.load(mement)
  end

  def push_mement
    @mement_stack ||= []
    @mement_stack << create_mement
  end

  def undo
    restore_mement(@mement_stack.shift)
  end
end

class MementFrame < Frame
  include MementControlMethods
  include MementSaveableMethods

  def next_frame
    # 1Pのlevelチェックしかしていない点に注意。
    # 本当は segment_level が上った時だけ処理を行いたい。
    # 改善の余地あり。
    super

    flash_seginfo
  end

  def flash_seginfo
    # 本当は segment_level が上った時だけ処理を行いたい。
    @seginfo ||= []
    @players.each_with_index{|e, i|
      @seginfo[i] ||= []
      raise "セグメント情報がありません。" unless e.controller.segment_level
      if @seginfo[i][e.controller.segment_level].nil?
        @seginfo[i][e.controller.segment_level] = create_mement
      end
    }
  end

  def save_direct_info
    @players.each_index{|i|
      @seginfo[i] << create_mement
    }
  end

  def start(fps=0, &pblock)
    flash_seginfo

    @seginfo1 = create_mement   # なくてもよい。
    ret = super(fps, &pblock)
    @seginfo2 = create_mement   # 必要。これも使ってない？

    # 最後の状態を記録
    save_direct_info

    ret
  end
end
