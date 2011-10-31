# -*- coding: utf-8 -*-
# 練習モード

require "parsedate"
require "uri"

require "play"
require "input"
require "pattern"
require "recfile"

require "signal_observer"
require "with_sound"

require "ui/sdl/input"
require "ui/frame"

class SimulateController < BaseController
  def initialize(speed=nil)
    super()
    @level_info = LevelInfo.new(speed || 20.0, 0.01, 26/2, 49/2, 15, nil, 3)
    @mode_name = "Simulation"
    @start_delay = 30
  end

  # 使われていない
  def sim_next_delay
    @level_info.flash_delay + @level_info.fall_delay + @level_info.next_delay2
  end

  # 使われていない
  def sim_next
    @level_info.flash_delay + @level_info.next_delay
  end
end

class FastSimulateController < SimulateController
  include SoundController # 音を出すかどうか

  def initialize(speed=nil)
    super()
                        # :speed, :acceleration, :next_delay, :fall_delay, :next_delay2, :lock_delay, :flash_delay)
    # @level_info = LevelInfo.new(speed || 20.0, 0,     4,           4,           4,            nil,          3)

    @level_info = LevelInfo.new(speed || 20.0, 0,     1,           1,           1,            nil,          2)
    @power_delay = 0  # 横溜め
    @start_delay = 2
  end
end

class SimulateDSController < SimulateController
  def initialize(*)
    super
    @level_info = LevelInfo.new(speed || 20.0, 0.01, 26 / 2, 49 / 2, 15, 45, 3)
    @up_put = true              # 上を押して固定できる
    @down_put = false           # ブロックが設置しているときに下を入れて固定できない
    @mode_name = "DS Simulation"
  end
end


class SimulateFrame < Frame
  include MementControlMethods
  def initialize(params)
    @fields = [Field.create(params[:field])]
    @players = [
      Player.new(@fields[0], 4, Players::Player1.new, Pattern::OriginalRec.new(params[:pattern]), params[:controller], params[:mino_factory])
    ]
  end
end

class AutoPlayFrame < Frame
  # include MementControlMethods ←これを入れるとおかしくなる。
  # params[:controller] の保存に失敗しているのかも
  # SimulateFrame との違いは Players::Players だからここが原因か？
  # ↑は関係なかった

  attr_reader :simulator_params

  def initialize(params)
    @simulator_params = params
    @fields = [Field.create(params[:field])]
    @players = [
      Player.new(@fields[0], 4, TextInputUnit.new(params[:input]), Pattern::Original.new(params[:pattern]), params[:controller], params[:mino_factory]),
    ]
  end
end

class SimHash < Hash
  def to_a
    [
      self[:title],
      self[:pattern],
      to_s_difficulty,
      sample_exist? ? "○" : "",
      to_s_date,
      self[:author],
      get_url ? "○" : "",
      self[:comment],
    ].collect{|e|e.to_s}
  end

  def to_s_difficulty
    v = self[:difficulty] || 0
    "★" * v + "☆" * (v.modulo(1.0) + 0.5)
  end

  def to_s_date
    v = self[:date].to_s
    v.empty? ? "" : Time.local(*ParseDate.parsedate(v)[0..5]).strftime("%y-%m-%d")
  end

  alias inspect_old inspect
  def inspect
    "[" + to_a.join(",") + "]"  # fieldのメンバが出力されると可読性が落ちるため
  end

  ################################################################################
  # 便利メソッド
  ################################################################################

  def sample_exist?
    !self[:input].to_s.empty?
  end

  def get_url
    return nil if self[:url].to_s.empty?
    begin
      URI.parse(self[:url])
      self[:url]
    rescue URI::InvalidURIError
      nil
    end
  end

  def open_url
    return unless get_url
    Tool.open_url(get_url)
  end

  def get_escape_title          # タイトルをURLとして使えるうな文字列に変換
    self[:title].gsub(/[\s,!<>&:%\^\*\|\[\]\(\)\.]+/,"").gsub(/\?/, "？")
  end

  ################################################################################
  # 委譲
  ################################################################################

  def start(fps=60)
    Simulator.start(self, fps)
  end
  def view
    Simulator.view(self)
  end
  def start_auto(fps=60)
    Simulator.start_auto(self, fps) if sample_exist?
  end

end

def __root_binding__
  binding
end

module Simulator
  module_function

  # ファイルをevalしてHashを拡張したオブジェクトの配列にする
  def load_file(fname)
    # __FILE__, __LINE__+1 を指定してしまうと読み込みファイル内の $0 == __FILE__ 内ブロックが実行されてしまうので指定してはいけない。
    library = open(fname){|io|eval(io.read, __root_binding__)}
    load_library(library)
  end

  # ファイルをevalしてHashを拡張したオブジェクトの配列にする
  def load_library(library)
    # __FILE__, __LINE__+1 を指定してしまうと読み込みファイル内の $0 == __FILE__ 内ブロックが実行されてしまうので指定してはいけない。
    library.collect{|e|SimHash[e].freeze}
  end

  # 通常の繰り返し練習
  def start(data, fps=60)
    frame = SimulateFrame.new(data)
    ui = UI::SimulateFrameDraw.new(frame)
    ui.set_title(data[:title])
    ret = nil
    loop {
      # 繰り返し練習するため
      frame.push_mement
      ret = frame.start(fps){}
      break if ret == :break
      frame.undo
    }
    ui.close
    ret
  end

  # 静止画表示
  # 作り的な問題でGDKでなければpauseが効かない
  def view(data)
    frame = SimulateFrame.new(data)
    ui = UI::SimulateFrameDraw.new(frame)
    ui.set_title(data[:title])
    frame.safe_show
    ui.pause
    ui.close
  end

  # 見本プレイ
  def start_auto(data, fps=60)
    return if data[:input].nil?
    frame = AutoPlayFrame.new(data)
    ui = UI::SimulateFrameDraw.new(frame)
    ui.set_title(data[:title])
    ret = frame.start(fps)
    ui.close
    ret
  end
end

# MPEG変換
module Simulator
  class MovieFactory
    attr_accessor :group, :jpeg_dir, :local_mpeg, :joined_mpeg, :merge_mp3, :overwrite

    def initialize
      set_group("default")
      set_jpeg_dir("default")
      set_mpeg_title("default")
      set_joined_mpeg("default")
      set_merge_mp3(nil)

      @overwrite = true
    end

    # 環境設定 #####################################################################
    def set_group(group)
      @group = group
    end
    def set_jpeg_dir(mpeg_title)
      @jpeg_dir = File.join(CONFIG[:snapdir], @group, mpeg_title)
    end
    def set_mpeg_title(mpeg_title)
      @local_mpeg = File.join(CONFIG[:mpegdir], @group, mpeg_title + ".mpg")
    end
    def set_joined_mpeg(joined_mpeg_title)
      @joined_mpeg = File.join(CONFIG[:mpegdir], joined_mpeg_title + ".mpg")
    end
    def set_merge_mp3(merge_mp3)
      @merge_mp3 = merge_mp3
    end
    ################################################################################

    def data_to_mpeg(data)
      return true if !@overwrite && File.exist?(@local_mpeg)
      return false if data[:input].nil?
      frame = AutoPlayFrame.new(data)
      RecFile.mpeg_convert(frame, @local_mpeg, @jpeg_dir)
    end

    def library_to_mpeg(library)
      outputs = []
      library.each_with_index{|e, i|
        mpeg_title = [i, e.get_escape_title].compact.join("-")
        set_jpeg_dir(mpeg_title)
        set_mpeg_title(mpeg_title)
        if data_to_mpeg(e)
          outputs << @local_mpeg
        end
      }
      if outputs.size >= 1
        if Tool.mpeg_join(@joined_mpeg, outputs)
          if @merge_mp3 && File.exist?(@merge_mp3)
            Tool.mpeg_add_audio(@joined_mpeg, @merge_mp3)
          end
          true
        end
      end
    end

    def file_to_mpeg(fname)
      set_group(File.basename(fname, ".rb"))
      set_joined_mpeg(File.basename(fname, ".rb"))
      library_to_mpeg(Simulator.load_file(fname))
    end

    def files_to_mpeg(files=Dir[File.join(CONFIG[:simdir], "*.rb")])
      files.each{|fname|
        file_to_mpeg(fname)
      }
    end
  end
end

if $0 == __FILE__
  data = {
    :title => "t1",
    :comment => "",
    :controller => FastSimulateController.new,
    :pattern => "bgr",
    :field => <<-EOT,
    ..........
    .....bbbbb
    bbb..bbbbb
    bbb..bbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    bbb.bbbbbb
    EOT
    :input => <<-EOT,
    Al| d
    Al| d
     l| d *
    EOT
  }

  # 見本プレイ
  2.times do
    frame = AutoPlayFrame.new(data)
    ui = UI::DrawFrame.new(frame)
    ret = frame.start(60)
    ui.close
  end

  exit


  library = Simulator.load_file("simulator/ipepapi_boyaki.rb")
  Simulator.view(library[0])

  #   fname = "simulator/詰めテト-ZON.rb"
  #   Simulator.file_to_mpeg(fname, "_all.mpg")

  #   fname = "simulator/詰めテト-ZON.rb"
  #   library = Simulator.load_file(fname)
  #   Simulator.data_to_mpeg(library[0], "_tmp.mpg")


  #   library = Simulator.load_file("simulator/ブロック操作最適化.rb")
  #   Simulator.view(library[0])

  #  fname = "simulator/詰めテト-ZON.rb"

  #   fname = "simulator/テトリス情報ページぼやき.rb"
  #   File.join(CONFIG[:mpegdir], File.basename(fname))

  # Simulator.library_to_mpeg(Simulator.load_file(fname), "_output.mpg", "PowerGen.mp3")

  #   factory = Simulator::MovieFactory.new
  #   factory.files_to_mpeg(["simulator/test.rb"])

  #   factory = Simulator::MovieFactory.new
  #   factory.files_to_mpeg
end
