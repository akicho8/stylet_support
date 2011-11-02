# -*- coding: utf-8 -*-
# テトリスベースクラス

require "pp"
require "kconv"
require "pathname"
require "generator"
require "jcode"

require File.expand_path(File.join(File.dirname(__FILE__), "rubyext"))
require File.expand_path(File.join(File.dirname(__FILE__), "area"))

# ユーティリティ
class Point

  # 方向テーブル
  VectorTable = [
    [+0, +1],                   # DOWN
    [-1, +0],                   # LEFT
    [+0, -1],                   # UP
    [+1, +0],                   # RIGHT
  ]

  # 方向番号
  DOWN  = 0
  LEFT  = 1
  UP    = 2
  RIGHT = 3
  DIR_N = 4

  String2Dir = {
    "u" => UP,
    "d" => DOWN,
    "l" => LEFT,
    "r" => RIGHT,
  }

  attr_accessor :x, :y

#   def self.kanji(index)
#     "下左上右".scan(/./)[index]
#   end

  def self.[](x, y)
    new(x, y)
  end

  def initialize(x, y)
    set_xy(x, y)
  end

  def set_xy(x, y) # Constructor Parameter Method
    @x, @y = x, y
  end

  def translate(obj=nil, extent=1)
    if obj.nil?
      Point.new(@x, @y)
    elsif obj.is_a? Array
      x, y = obj
      Point.new(@x + x * extent, @y + y * extent)
    elsif obj.is_a? Point
      Point.new(@x + obj.x * extent, @y + obj.y * extent)
    else
      translate(VectorTable[obj], extent)
    end
  end

  def translate!(obj, extent=1)
    set_xy(*translate(obj, extent).to_a)
  end

  def to_a
    [@x, @y]
  end

  def inspect
    "(#{@x},#{@y})"
  end

  def ==(other)
    @x == other.x && @y == other.y
  end
end

# 方向クラス
class Direction
  TURN_LEFT = -1                # 左回転
  TURN_RIGHT = +1               # 右回転

  def initialize(dir=Point::DOWN)
    set(dir)
  end

  def set(dir)
    dir = Point::String2Dir.fetch(dir.downcase[0..0]) if dir.is_a? String
    @value = dir
  end

  def to_i
    @value
  end

  def rotate(turn=TURN_LEFT)
    (@value + Point::DIR_N + turn).modulo(Point::DIR_N)
  end

  def rotate!(turn=TURN_LEFT)
    @value = rotate(turn)
  end

  def inspect                   # 方向から文字列を取得
    %w(↓ ← ↑ →)[@value]
  end

  def jinspect               # 方向から日本語の表現に変換
    %w(下 左 上 右)[@value]
  end

  def to_s_en                  # 方向から英語の表現に変換
    %w(down left up right)[@value]
  end

  # 現在の方向から target の方向を向きたいときに一番近い回転方向を返す。
  def get_turn_to(target)
    if ((target.to_i - @value + Point::DIR_N) % Point::DIR_N) >= Point::DIR_N / 2
      TURN_LEFT
    else
      TURN_RIGHT
    end
  end

  def ==(other)
    self.to_i == other.to_i
  end
end

module Mino
  class Base
    BASE_X = 1                  # ブロックのローカル座標での原点
    BASE_Y = 1
    attr_reader :pos, :dir, :field

    def initialize
      super
      @dir = Direction.new
      @pos = Point.new(BASE_X, BASE_Y)
      @field = nil
    end

    def shape                   # 形状
      self.class.shape
    end

    def color                   # デフォルトの色
      self.class.color
    end

    def color_char
      self.color.scan(/./).first.downcase
    end

    def jcolor                  # デフォルトの色(日本語一文字)
      self.class.jcolor
    end

    def shape_char              # 形を文字で表す
      self.class.shape_char
    end

    alias to_s_old to_s
    def to_s(type = nil)
      case type
      when :nickname
        "#{self.jcolor}色(#{self.shape_char.upcase}型)"
      else
        to_s_old
      end
    end

    def set_pos(pos)            # ブロックの位置を設定
      @pos = pos
      self
    end

    def set_x(x)                # X座標設定
      @pos.x = x
      self
    end

    def set_y(y)                # Y座標設定
      @pos.y = y
      self
    end

    def get_x                   # X座標取得
      @pos.x
    end

    def get_y                   # Y座標取得
      @pos.y
    end

    def x()   @pos.x   end
    def y()   @pos.y   end
    def x=(x) @pos.x=x end
    def y=(y) @pos.y=y end

    def view_color              # 表示上の色
      color
    end

    def attach(field)           # 所属するフィールドを設定
      @field = field
      self
    end

    def moveable?(dir=Point::DOWN) # 指定方向に移動出来る?
      @field.writeable?(get_points, @pos.translate(dir))
    end

    def under_fall?             # 落下中か?
      moveable?
    end

    def grounding?              # 接地しているか?
      !under_fall?
    end

    def place?                  # この場所に置くことが出来るか?
      moveable?(nil)
    end

    def move(dir=Point::DOWN) # 指定方向に移動する
      if moveable?(dir)
        @pos.translate!(dir)
        true
      else
        false
      end
    end

    def dash(dir=Point::DOWN) # 指定方向へ付き当るまで移動する
      count = 0
      while move(dir)
        count += 1
        yield if block_given?
      end
      count
    end
    alias fall dash

    # 初期配置
    def set_start_pos
      set_pos(Point.new(@field.width / 2 - 1, Field::INVISIBLE_AREA))
    end

    # puton{〜} と書けば、ブロックを書き込んだ状態でフィールドを処理し、抜けたらブロックがあった場所だけ消される。
    def puton(life_count=nil)   # フィールドに書き込む Field.open 風のi/f
      @field.set_points(get_points, color, @pos, life_count)
      return self unless block_given?
      begin
        yield self
      ensure
        putoff
      end
    end

    def putoff                  # フィールドから外す
      @field.unset_points(get_points, @pos)
    end

    # 現在のブロックを置くと何行そろうか?
    def attempt_complate_lines
      puton {@field.complate_info.size}
    end

    # 軸補正付き回転
    # 各ブロックによってオーバーライドされる
    # 上への軸補正を許可すると水色がくぼみから抜け出せる
    def rotate_with_correct!(turn=Direction::TURN_LEFT)
      unless rotate!(turn)
        unless rotate!(turn, Point::RIGHT)
          unless rotate!(turn, Point::LEFT)
            return false
          end
        end
      end
      true
    end

    # turn したブロックの状態が、dir 方向に extent セル分移動してはまれば書き込む
    def rotate!(turn=Direction::TURN_LEFT, dir=nil, extent=1)
      if @field.writeable?(get_points(@dir.rotate(turn)), @pos.translate(dir, extent))
        @dir.rotate!(turn)
        @pos.translate!(dir, extent)
        true
      else
        false
      end
    end

    def get_points(dir=@dir.to_i) # ブロックを構成するセルの位置を配列で返す
      shape[dir.modulo(shape.size)]
    end

    def each_dir                # 方向の回数だけ回す
      shape.size.times{|dir|
        yield dir
      }
    end

    alias inspect_old inspect
    def inspect
      "<#{color}(#{shape_char}) pos=#{@pos.inspect} dir=#{@dir.to_s_en} object_id=#{self.object_id}>"
    end

    def clone
      Marshal.load(Marshal.dump(self))
    end

    def pos_info                # 現在の位置と方向をシンプルに返す
      [@pos.dup, @dir.to_i]
    end

    def ==(other)
      self.class == other.class && self.pos == other.pos && self.dir == other.dir
    end

  end
end

module Mino

  class Shape < Array
    attr_reader :dir_name

    def initialize(dir_name, shape_string)
      @dir_name = dir_name
      parse_shape_string(shape_string)
    end

    def parse_shape_string(shape_string)
      shape_string = shape_string.collect{|line|line.strip} * "\n"
      shape_string = shape_string.collect{|line|line.scan(/./)}
      shape_string.each_with_index{|line, y|
        line.each_with_index {|ch, x|
          self << Point.new(x-Base::BASE_X, y-Base::BASE_Y).freeze if ch == "o"
        }
      }
    end

    def dir_name_jp
      {
        "down"     => "下",
        "left"     => "左",
        "up"       => "上",
        "right"    => "右",
        "flat"     => "横",
        "straight" => "縦",
        "symmetry" => "前",
      }[@dir_name]
    end
  end

  class << Base
    attr_accessor :shape, :color, :jcolor, :shape_char, :first_appear

    # initialize の変わりとして Mino::Base が継承された直後に初期値を設定する
    def inherited(sub)
      sub.class_eval{
        self.first_appear true
      }
    end

    def first_appear(flag)
      @first_appear = flag
    end

    # 最初に出現する気があるか?
    def first_appear?
      @first_appear
    end

    def range_vicinity(method=nil)              # 辺の大きい方を返す
      if method
        ary = @shape.collect{|e| e.collect{|v|v.send(method)}}.flatten
        (ary.min..ary.max).to_a.size
      else
        [range_vicinity(:x), range_vicinity(:y)].max
      end
    end

    def get_dir_num             # 何個の方向を持っているか?
      @shape.size
    end

    def get_cell_num          # 何個のセルで構成されているか?
      @shape.first.size
    end

    def parse_string(arg) # ブロックの文字列表記から実際の座標配列に変換
      arg = str_split(arg)
      comp = []
      arg.each_with_index {|dir,dirno|
        comp[dirno] = []
        dir.each_with_index {|line,y|
          line.each_with_index {|ch,x|
            comp[dirno] << Point.new(x-Base::BASE_X, y-Base::BASE_Y).freeze if ch == "o"
          }
        }
      }
      comp.freeze
    end

    def str_split(arg)
      arg = arg.collect{|line|line.strip} * "\n"
      arg = arg.split(/\n-+\n+/).collect{|e|e.collect{|s|s.scan(/./)}}
    end

  end
end

require File.expand_path(File.join(File.dirname(__FILE__), "classic"))
require File.expand_path(File.join(File.dirname(__FILE__), "world"))
require File.expand_path(File.join(File.dirname(__FILE__), "cell"))
require File.expand_path(File.join(File.dirname(__FILE__), "life_cell"))

class Field
  INVISIBLE_AREA = 2          # フィールド上の不可視領域の推奨ライン数

  def self.create(field_string=nil)
    new([10,20+INVISIBLE_AREA], field_string)
  end

  def initialize(wh=Mino::Classic.field_area, field_string=nil)
    # 空のフィールド生成
    resize(wh)

    # 文字列からフィールドを作成する
    if field_string
      self.field_string(field_string)
    end
  end

  # 文字列からフィールドを作成する
  def field_string(field_string)
    # mino_str = Mino::Classic.validity_alpha_colors
    field_string = field_string.collect{|line|line.strip.scan(/./)}.reverse
    field_string.each_with_index {|line, y|
      line.each_with_index{|ch, x|
        # if mino_str.include?(ch)
        unless ch.match(/[\s\.]/io)
          get(x, bottom - y).set(ch)
        end
      }
    }
  end

  # フィールドの大きさを再構成する(セルはクリアされる)
  def resize(wh)
    @area = Area.new(wh)
    # フィールドを10x22とした時、(0,0)が左上、(9,23)が右下を表わす
    @cellarray = Array.new(@area.height) {
      Array.new(@area.width){LifeCell.new}
    }
    self
  end

  def width;   @area.width;  end
  def height;  @area.height; end
  def height2; @area.height - INVISIBLE_AREA; end

  def top;    @area.top;    end
  def bottom; @area.bottom; end
  def left;   @area.left;   end
  def right;  @area.right;  end

  def get(x, y)                 # 指定セルを取得
    return nil unless @area.contains(x, y) # -1でアクセスさせないため
    @cellarray[y][x]
  end

  def xarray(y)                 # 横の配列取得
    @cellarray[y]
  end

  def yarray(x)                 # 縦の配列取得
    @cellarray.transpose[x]
  end

  # 全てのセルを順番に渡す
  def cell_each_with_index
    width.times {|x|
      height.times {|y|
        yield get(x, y), x, y
      }
    }
    self
  end

  # 条件が一致したセルを返す
  def cell_detect_with_index
    width.times {|x|
      height.times {|y|
        return get(x, y) if yield get(x, y), x, y
      }
    }
    nil
  end

  def cell_count             # 生きているセルの数
    count = 0
    cell_each_with_index {|c, x, y|count +=1 if c.exist?}
    count
  end

  def clear!                    # 全セルクリア
    cell_each_with_index {|c, x, y|c.clear!}
    self
  end

  def next_frame                        # セルを次の状態に移行
    cell_each_with_index {|c, x, y|c.next!}
    self
  end

  def cell_show_all                     # セルを全て表示する
    cell_each_with_index {|c, x, y|c.show!}
    self
  end

  def exist?(x, y) # 指定座標にセルは存在するか?(壁もセルの一部とする)
    return true unless @area.contains(x, y)
    get(x, y).exist?
  end

  def writeable?(points, _pos=Point[0,0])       # pointsは_posの位置に書き込めるか?
    !points.detect {|po| exist?(_pos.x+po.x, _pos.y+po.y)}
  end

  def set_points(points, color, _pos=Point[0,0], life_count=nil) # pointsを_posの位置に設定
    points.each {|po|
      if !exist?(_pos.x+po.x, _pos.y+po.y)
        cell = get(_pos.x+po.x, _pos.y+po.y)
        cell.set(color)
        cell.set_life_count(life_count)
      end
    }
    self
  end

  # _posの位置からpointsを削除
  def unset_points(points, _pos=Point[0,0])
    points.each {|po|
      if cell = get(_pos.x+po.x, _pos.y+po.y) # セルが取得できたら削除
        cell.clear!
      end
    }
    self
  end

  def to_s(options = {})
    if options[:ustrip]
      options[:top] ||= get_top
    end
    options = {:top => top, :bottom => bottom, :style => "default"}.merge(options)
    str = ""
    case options[:style]
    when "default"
      (options[:top] .. options[:bottom]).each {|y|
        width.times {|x| str << get(x, y).to_s}
        str << "\n"
      }
    when "wiki"
      (options[:top] .. options[:bottom]).each {|y|
        str << "｜"
        width.times {|x|
          cell = get(x, y)
          if cell && cell.exist?
            if cell.color == "x"
              char = "□"
            elsif cell.color == "*"
              char = "◇"
            else
              char = "■"
            end
          else
            char = "　"
          end
          str << char
        }
        str << "｜\n"
      }
      str << "└" + "─" * width + "┘" + "\n"
    else
      raise "invalid options[:style]: #{options[:style]}"
    end
    str
  end

  def get_top(x=nil)           # 指定した列の一番上のセルのy座標を得る
    if x
      height.times {|y| return y if exist?(x, y)}
      height
    else
      y = height
      width.times {|x| y = get_top(x) if y > get_top(x)}
      y
    end
  end

  def get_top2(x=nil)       # ブロックの高さ(サイズ)
    height - get_top(x)
  end

  alias inspect_old inspect
  def inspect
    lines = to_s(:ustrip => true).split(/\n/)
    return "field empty" if lines.size == 0
    columns = lines.first.size
    str = ""
    str << lines.enum_with_index.collect{|e,i|('%2d' % (get_top + i)) + '|' + e + "|\n"}.to_s
    str << "   " << ("-" * columns) << "\n" << "   "
    columns.times{|i| str << (i % 10).to_s}
    str << "\n"
  end

  def damage(x=nil)             # 指定列の隙間の数を得る
    count = 0
    if x
      (get_top(x)..bottom).each {|y| count+=1 if !exist?(x, y)}
    else
      width.times {|x| count += damage(x)}
    end
    count
  end

  def all_clear?                # 全消し?
    damage == 0 and flat?
  end

  alias clear? all_clear?

  def roughness         # デコボコ度を得る
    count = 0
    (width-1).times {|x| count += (get_top(x) - get_top(x+1)).abs}
    count
  end

  def roughness2(x=nil)         # デコボコ度を得る
    if x
      l = get_top2(x-1)
      c = get_top2(x)
      r = get_top2(x+1)
      (l - c).abs + (r - c).abs
    else
      count = 0
      (width-1).times{|x|count += roughness2(x)}
      count
    end
  end

  def hole?(x)          # 指定の桁はそこだけ穴になっているか? 穴の深さは roughness2 で求まる。
    l = get_top2(x-1)
    c = get_top2(x)
    r = get_top2(x+1)
    c < l && c < r
  end

  def flat?                     # 平ら?
    roughness == 0
  end

  # これは必要。
  def clone
    Marshal.load(Marshal.dump(self))
  end

  # なんのためだっけ?
  def ==(other)
    !cell_detect_with_index{|c, x, y| c != other.get(x, y)}
  end

  # 指定した水平ラインのセルの数取得
  def get_cell_count_of_xline(y)
    xarray(y).find_all{|e|e.exist?}.size
  end

  # 消すラインの行番号配列を返す
  def complate_info
    (top..bottom).find_all{|y|get_cell_count_of_xline(y) == width}.to_a
  end

  # 指定した行を消去する
  def _clear_lines(lines)
    lines.each{|y|
      xarray(y).each {|obj| obj.clear!}
    }
    self
  end

  # 指定した行を詰める。引数を省略すると横一列になっているブロックを外して下に詰める
  def reject_lines(lines=complate_info)
    lines.sort.each {|line|
      line.downto(1) {|y|
        width.times {|x|
          get(x, y).replace(get(x, y-1))
        }
      }
    }
    _clear_lines([0])
  end

  # 別のオブジェクトで置換する。ただし、フィールドサイズは変わらない。フィールドは文字列での指定も可。
  # もしフィールドサイズを変更したい場合は元のフィールドを resize してから replace すればよい。
  def replace(other)
    other = Field.new(@area, other) if other.is_a? String
    clear!
    cell_each_with_index{|c, x, y|
      o = other.get(x, y)
      c.replace(o) if o.exist?
    }
    self
  end

  # 現在の状態で全消しするために必要な残りセル数は?(バックトラック用)
  def get_cell_count_for_ac
    count = 0
    (get_top..@area.bottom).each {|y|
      @area.width.times {|x|
        count += 1 unless get(x, y).exist?
      }
    }
    count
  end
end

# ブロックを上げるために必要なメソッド。
class Field
  def rise_line(ary=[])
    # ブロック全体を下から上に一行上げる。
    copy_to_up

    # 一番下に書き込む
    width.times {|x|
      get(x, bottom).set(ary[x])
    }
  end

  # 下から上にブロックを一行コピーする
  # 一番下の行はまだ存在する。
  def copy_to_up
    (1..bottom).each {|y|
      width.times {|x|
        get(x, y-1).replace(get(x, y))
      }
    }
  end
end

class Field
  attr_accessor :edge
end

if $0 == __FILE__
  x = Mino::Classic::Yellow.new
  p x
  p Mino::Classic::Yellow.class_eval{@first_appear}
  # p Mino.list
  # p Mino.list.last.color
  p Mino::Classic.list
  p Mino::World.list
  p Mino::Classic.create(0)
  p Mino::World.create(0)
  p Mino::World::Cyan.shape
end
