require "active_support/concern"

module Stylet
  module Shared
    # Point.new             # => [nil, nil]
    # Point[1, 2]           # => [1, 2]
    # Point[1, 2].members   # => [:x, :y]
    # Point[1, 2].values    # => [1, 2]
    # Point[1, 2]           # => [1, 2]
    # Point.new(Point[1,2]) # => [1, 2]
    # Point[Point[1,2]]     # => [1, 2]
    # Vector.new.to_h       # => {:x=>0.0, :y=>0.0}
    # Vector.new(1, 2).to_h # => {:x=>1, :y=>2}
    def initialize(*args)
      if args.empty?
        args = [0.0] * members.size
      elsif args.size == 1 && args.first.respond_to?(:values)
        args = args.first.values
      end
      super(*args)
    end

    # Vector.zero.inspect # => "[0.0, 0.0]"
    def inspect
      values.inspect
    end

    # Vector.zero.to_s # => "[0.0, 0.0]"
    def to_s
      values.inspect
    end
  end

  class Point2 < Struct.new(:x, :y)
    include Shared
  end

  class Point3 < Struct.new(:x, :y, :z)
    include Shared
  end

  Point = Point2

  class ZeroVectorError < StandardError; end

  module BasicVector
    extend ActiveSupport::Concern

    included do
    end

    class_methods do
      # ゼロベクトルを返す
      #   Vector.zero.to_a # => [0.0, 0.0]
      def zero
        new(*Array.new(members.size) { 0.0 })
      end

      # メンバーが 1.0 のベクトルを返す
      #   Vector.one.to_a # => [1.0, 1.0]
      def one
        new(*Array.new(members.size) { 1.0 })
      end

      # ランダムを返す
      #   Vector.rand            # => [0.017480344343668852, 0.8764385584061907]
      #   Vector.rand(3)         # => [2, 2]
      #   Vector.rand(3..4)      # => [4, 3]
      #   Vector.rand(3.0..4)    # => [3.969678485069191, 3.4220406563055144]
      #   Vector.rand(-2.0..2.0) # => [-1.6587999052626938, 0.5996185615991392]
      def rand(*args)
        if args.empty?
          args = [-1.0..1.0]
        end
        new(*members.collect { Kernel.rand(*args) })
      end

      # ゼロベクトルを作ろうとすると例外を出す new
      def safe_new(*args)
        new(*args).tap do |obj|
          raise ZeroVectorError if obj.zero?
        end
      end

      # # 1.0 と -1.0 で構成したランダム値
      # def nonzero_random_new
      #   new(*members.collect{Chore.nonzero_random})
      # end

      # 内積
      def dot_product(a, b)
        members.collect { |m| a.send(m) * b.send(m) }.reduce(0, :+)
      end

      # # 外積
      # def cross_product(a, b)
      #   members.collect {|m|
      #     (members - [m]).collect {|n| a.send(m) * b.send(n) }
      #   }.flatten.reduce(0, :+)
      # end
    end

    [
      { :name => :add, :sym => :+ },
      { :name => :sub, :sym => :- },
    ].each do |attr|
      define_method(attr[:name]) do |o|
        unless o.is_a? self.class
          o = self.class.new(*o.to_ary)
        end
        self.class.new(*members.collect { |m| Float(send(m)).send(attr[:sym], o.send(m)) })
      end
      define_method("#{attr[:name]}!") do |*args|
        replace(send(attr[:name], *args))
      end
      alias_method attr[:sym], attr[:name]
    end

    [
      { :name => :scale, :sym => :* },
      { :name => :div,   :sym => :/ },
    ].each do |attr|
      define_method(attr[:name])       { |*args| apply(attr[:sym], *args)  }
      define_method("#{attr[:name]}!") { |*args| apply!(attr[:sym], *args) }
      alias_method attr[:sym], attr[:name]
    end

    alias mul scale
    alias mul! scale!

    # Vector.rand.round.to_a    # => [1, 0]
    # Vector.rand.round(2).to_a # => [0.37, 0.92]
    # Vector.rand.floor.to_a    # => [0, 0]
    # Vector.rand.ceil.to_a     # => [1, 1]
    # Vector.rand.truncate.to_a # => [0, 0]
    [:ceil, :floor, :round, :truncate].each do |name|
      define_method(name)        { |*args| apply(name, *args)  }
      define_method("#{name}!")  { |*args| apply!(name, *args) }
    end

    # メンバーだけ更新(主に内部用)
    #
    #   v = Vector.new
    #   v.object_id            # => 70228805905160
    #   v.replace(Vector.rand) # => [-0.5190386805455354, -0.5679474000175717]
    #   v.object_id            # => 70228805905160
    #
    def replace(other)
      tap { members.each { |m| send("#{m}=", other.send(m)) } }
    end

    # 単位ベクトル化
    #   Vector.one.normalize       # => [0.7071067811865475, 0.7071067811865475]
    def normalize
      raise ZeroVectorError if zero?
      c = magnitude
      self.class.safe_new(*values.collect { |v| Float(v) / c })
    end

    def normalize!
      replace(normalize)
    end

    # ベクトルの大きさを返す
    #   Vector.one.magnitude       # => 1.4142135623730951
    def magnitude
      Math.sqrt(magnitude_sq)
    rescue Errno::EDOM => error
      warn "(p - p).magnitude と書いているコードがあるはず。それをやると sqrt(0) になるので if p != p を入れよう: #{values.inspect}"
      raise error
    end

    def magnitude_sq
      values.collect { |v| v**2 }.inject(0, &:+)
    end

    alias length magnitude
    alias length_sq magnitude_sq

    # 反対方向のベクトルを返す
    #   Vector.one.reverse # => [-1.0, -1.0]
    def reverse
      self.class.new(*values.collect(&:-@))
    end

    # -Vector.one # => [-1.0, -1.0]
    alias -@ reverse

    # 内積
    #   Vector[1, 0].dot_product(Vector[1, 0])   # => 1.0
    #   Vector[1, 0].dot_product(Vector[-1, 0])  # => -1.0
    def dot_product(other)
      self.class.send(__method__, self, other)
    end

    # 相手との距離を取得
    #   Vector.zero.distance_to(Vector.one) # => 1.4142135623730951
    def distance_to(target)
      (target - self).magnitude
    end

    # 0ベクトルか？
    #   Vector.zero.zero? # => true
    def zero?
      values.all?(&:zero?)
    end

    # 0ベクトルではない？
    #   Vector.one.nonzero? # => true
    def nonzero?
      !zero?
    end

    private

    def apply(method, *args)
      self.class.new(*apply_values(method, *args))
    end

    def apply!(method, *args)
      replace(apply(method, *args))
    end

    def apply_values(method, *args)
      members.collect { |m| Float(send(m)).send(method, *args) }
    end
  end

  #
  # ベクトル
  #
  # 移動制限のつけ方
  #
  #   if vec.magnitude > n
  #     vec.normalize.scale(n)
  #   end
  #
  # 摩擦
  #
  #   vec.scale(0.9)
  #
  class Vector < Point
    include BasicVector

    # 外積
    # x1*y2-x2*y1 = |v1||v2|sin(θ)
    def self.cross_product(a, b)
      a.x * b.y - b.x * a.y
    end

    def cross_product(b)
      self.class.cross_product(self, b)
    end

    # 方向ベクトル
    #
    #   これを使うと次のように簡単に書ける
    #   cursor.x += Stylet::Magic.rcos(dir) * speed
    #   cursor.y += Stylet::Magic.rsin(dir) * speed
    #     ↓
    #   cursor += Stylet::Magic.angle_at(dir) * speed
    #
    def self.angle_at(x, y = x)
      new(Magic.rcos(x), Magic.rsin(y))
    end

    # 反射ベクトルの取得
    #
    #   s: スピードベクトル
    #   n: 法線ベクトル
    #
    #   定石
    #     速度ベクトル += 速度ベクトル.reflect(法線ベクトル).scale(反射係数)
    #     @speed += @speed.reflect(@normal).scale(0.5)
    #
    #   反射係数
    #     ×1.5: 謎の力によってありえない反射をする
    #     ◎1.0: 摩擦なし(標準)
    #     ◎0.8: 少し滑る
    #     ○0.6: かなり滑ってほんの少しだけ反射する
    #     ○0.5: 線に沿って滑る
    #     ×0.4: 線にわずかにめり込んだまま滑る
    #     ○0.0: 線に沿って滑る(突き抜けるかと思ったけど滑る)
    #
    #   hakuhin.jp/as/collide.html#COLLIDE_02 の方法だと x + t * n.x * 2.0 * 0.8 と一気に書いていたけど
    #   メソッド化するときには分解した方がわかりやすそうなのでこうした。
    #
    #   参考: 反射ベクトルと壁ずりベクトル
    #   http://marupeke296.com/COL_Basic_No5_WallVector.html
    #
    def reflect(n)
      slide(n) * 2.0
    end

    # スライドベクトル
    #
    # self: スピードベクトル
    #    n: 法線ベクトル
    #
    def slide(n)
      t = -(n.x * x + n.y * y) / (n.x**2 + n.y**2)
      n * t
    end

    # p: 現在地点
    # s: スピードベクトル
    # a: 線の片方
    # n: 法線ベクトル
    #
    # としたとき何倍したら線にぶつかるか
    #
    # 式の意味がまだ理解できてない
    #
    def self.collision_power_scale(p, s, a, n)
      d = -(a.x * n.x + a.y * n.y)
      -(n.x * p.x + n.y * p.y + d) / (n.x * s.x + n.y * s.y)
    end

    # 法線ベクトルの取得(方法1)
    # どう見ても遅い
    def slowly_normal(t)
      a = angle(t) + Magic.r90
      self.class.new(Magic.rcos(a), Magic.rsin(a))
    end

    # 法線ベクトルの取得(方法2)
    def normal(t)
      dx = t.x - x
      dy = t.y - y
      self.class.new(-dy, dx)
    end

    # 法線ベクトルの取得
    def prep
      self.class.new(-y, x)
    end

    #
    # 相手の方向を取得
    #
    def angle_to(target)
      (target - self).angle
    end

    # ベクトルから角度に変換
    #
    #   Math.atan2(y, x) * 180 / Math.PI に相当する
    #
    def angle
      Magic.angle(0, 0, x, y)
    end

    # 線分 A B の距離 1.0 をしたとき途中の位置ベクトルを取得
    #
    #   a と b の位置が同じ場合いろいろおかしくなる
    #
    def self.pos_vector_ratio(a, b, rate)
      a + angle_at(a.angle_to(b)) * (a.distance_to(b) * rate) # FIXME: ダメなコード
    end

    # 指定の角度だけ回転する
    #
    #   自分で最初に考えた方法
    #
    def rotate(a)
      self.class.angle_at(angle + a) * magnitude
    end

    def rotate!(*args)
      replace(rotate(*args))
    end

    # 指定の角度だけ回転する(方法2)
    #   他のいくつかのライブラリで使われている方法。
    def rotate2(a)
      tx = (x * Magic.rcos(a)) - (y * Magic.rsin(a))
      ty = (x * Magic.rsin(a)) + (y * Magic.rcos(a))
      self.class.new(tx, ty)
    end

    def rotate2!(*args)
      replace(rotate2(*args))
    end

    def to_2dv
      self
    end

    def to_3dv
      Vector3.new(*values, 0)
    end
  end

  class Vector3 < Point3
    include BasicVector

    def to_2dv
      Vector.new(*values.take(2))
    end

    def to_3dv
      self
    end
  end
end

if $0 == __FILE__
  # Stylet::Vector.rand * 2

  p0 = Stylet::Vector.new(1, 1)
  p1 = Stylet::Vector.new(1, 1)
  p(p0 + p1)
  p(p0.add(p1))
  p(p0.add!(p1))
  p(p0)
  p(Stylet::Vector.new(3, 4).magnitude)
  p(Stylet::Vector.new(3, 4).normalize.scale(5))
  p(-Stylet::Vector.new(3, 4))

  # p0 = Stylet::Vector.new(1, 1)
  # p1 = Stylet::Vector.new(1, 1)
  # p(p0 == p1)
  # p p0
  # p p0 + p1
  # p p0.add(p1)
  # p p0
  # p p0.add!(p1)
  # p p0
  #
  # p0 = Stylet::Vector.zero
  # p p0.normalize
end
# >> [2.0, 2.0]
# >> [2.0, 2.0]
# >> [2.0, 2.0]
# >> [2.0, 2.0]
# >> 5.0
# >> [3.0, 4.0]
# >> [-3, -4]
