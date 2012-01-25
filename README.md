物理運動アルゴリズムのお勉強用Ruby/SDLラッパーライブラリ
========================================================

## Ruby/SDL環境の作り方(for Mac OS X)

### 基本ライブラリのインストール

    sudo port install libsdl libsdl_ttf libsdl_sound libsdl_pango libsdl_mixer libsdl_image rb-opengl

### SGEのインストール(debianだと一発でインストールできたはず)

    sge030809.tar.gz をダウンロードして ~/Downloads/sge030809 に展開。
    http://coderepos.org/share/changeset/10163 から *.patch をダウンロードし ~/Downloads/sge030809 にコピー。
    cd ~/Downloads/sge030809
    patch -p1 < Makefile.conf.patch
    patch -p1 < Makefile.patch
    make
    sudo make install

### rubysdlのインストール(上のライブラリを更新、追加した場合は改めて↓を実行すること)

    gem install rubysdl rsdl

    Macの場合 ruby からではなく rsdl から実行する

## Hello, world の実行方法

    $ cat hello.rb
    # -*- coding: utf-8 -*-
    require "stylet"
    Stylet::Base.main_loop do |win|
      win.vputs "Hello, world."
    end

    $ bundle exec rsdl hello.rb
    [q]で終了

## サンプルの一括動作テスト方法

    $ cd examples
    ruby test_all.rb

## TIPS

### 速度ベクトルの向きを取得するには？

    speed.angle

### 速度ベクトルを45度傾けるには？

    speed + Stylet::Vector.angle_at(Stylet::Fee.r45) * speed.length
    
    Stylet::Vector.angle_at(speed.angle + Stylet::Fee.r45) * speed.length
    
    speed.rotate(Stylet::Fee.r45)
    
    speed.rotate2(Stylet::Fee.r45)

### p0の速度ベクトルをマウスの方向に設定するには？

    speed = Stylet::Vector.angle_at(p0.angle_to(win.mouse_vector)) * speed.length

### 円の速度制限をするには？(円が線から飛び出さないようにするときに使う)

    if speed.length > radius
      speed = speed.normalize.scale(radius)
    end

### 線分ABの中央の位置を取得するには？

    half_ab = pA + Stylet::Vector.angle_at(pA.angle_to(pB)) * (pA.distance_to(pB) / 2)

    Vector.pos_vector_rate(pA, pB, 0.5)

### 円(c,r)が点(dot)にめりこんだとき、点(dot)から円を押し出すには？

#### 悪い例

    if c.distance_to(dot) < r
      c = dot + Stylet::Vector.angle_at(dot.angle_to(c)) * r
    end

#### 良い例

    diff = c - dot
    rdiff = diff.length - r
    if rdiff > 0
      # c = dot + diff.normalize * r # ドットから押す場合(ドットが釘ならこれでもよい)
      c += diff.normalize * rdiff
    end

### 円Aと円Bをお互い離すには？(跳ね返り処理は別)

    diff = b - a
    rdiff = r * 2 - diff.length
    if rdiff > 0
      a -= diff.normalize * rdiff / 2
      b += diff.normalize * rdiff / 2
    end

###  固定点Aに円(p0,r)がめり込んでいたらAから跳ね返すには？

    diff = p0 - pA
    if diff.length > 0
      if diff.length < r
        p0 = pA + diff.normalize.scale(r)          # めりこみ解消
        speed = diff.normalize.scale(speed.length) # 跳ね返す
      end
    end

## 円Aと円Bが衝突してBからAを押したり引いたりするには？(Bは動かない。また両方跳ね返らない。Aは除けるだけ)

    r2 = ar + br
    if a != b
      diff = b - a
      rdiff = r2 - diff.length
      # 押す場合
      if rdiff > 0
        # a = b + diff.normalize * r2  # Bを基点に押し出す(1)
        b += diff.normalize * rdiff    # Aを基点に押し出す(2)
      end
      # 引く場合
      if rdiff < 0
        # (1) or (2) どちらでも
      end
    end

### 正規化とは斜めの辺の長さを 1.0 にすること

    v.normalize.length #=> 1.0

### A B C D ボタンとカーソルで操作できるとき物体(pA)と速度(speed)をコントロールするときの定石は？

    # AとBで速度ベクトルの反映
    @pA += @speed.scale(@win.button.btA.repeat_0or1) + @speed.scale(-@win.button.btB.repeat_0or1)
    # @pA += @speed.scale(@win.button.btA.repeat) + @speed.scale(-@win.button.btB.repeat) # 加速したいとき
 
    # Cボタンおしっぱなし + マウスで自機位置移動
    if @win.button.btC.press?
      @pA = @win.cursor.clone
    end
 
    # Dボタンおしっぱなし + マウスで自機角度変更
    if @win.button.btD.press?
      if @win.cursor != @pA
        # @speed = Stylet::Vector.angle_at(@pA.angle_to(@win.cursor)) * @speed.radius # ← よくある間違い
        @speed = (@win.cursor - @pA).normalize * @speed.length # @speed.length の時点で桁溢れで削れるのが嫌なら length.round とする手もあり
      end
    end

### 円が完全に重なっている場合、ランダムに引き離す定石

    diff = a - b
    if diff.length.zero?
      arrow = Stylet::Vector.nonzero_random_new
      a -= arrow * ar
      b += arrow * br
    end

### 同時押しをシミューレートするには？

    # A:←A S:←B D:→A F:→B
    @axis.left  << (SDL::Key.press?(SDL::Key::A) | SDL::Key.press?(SDL::Key::S))
    @axis.right << (SDL::Key.press?(SDL::Key::D) | SDL::Key.press?(SDL::Key::F))
    @button.btA << (SDL::Key.press?(SDL::Key::A) | SDL::Key.press?(SDL::Key::D))
    @button.btB << (SDL::Key.press?(SDL::Key::S) | SDL::Key.press?(SDL::Key::F))

### 内積を取得するには？

    v = Stylet::Vector.inner_product(a, b)
    #  1. ←← or →→ 正 (0.0 < v)   お互いだいたい同じ方向を向いている
    #  2. →←         負 (v   < 0.0) お互いだいたい逆の方向を向いている
    #  3. →↓ →↑    零 (0.0)       お互いが直角の関係

### TODO

* x1, y1 = points[i % points.size] は cons に置き換えれる

### 参考URL

* [Flashゲーム講座&アクションスクリプトサンプル集](http://hakuhin.jp/as.html)
* [基礎の基礎編その１ 内積と外積の使い方](http://marupeke296.com/COL_Basic_No1_InnerAndOuterProduct.html)
* [内積が角度になる証明](http://marupeke296.com/COL_Basic_No1_DotProof.html)
* [衝突判定編](http://marupeke296.com/COL_main.html)
* [反射ベクトルと壁ずりベクトル](http://marupeke296.com/COL_Basic_No5_WallVector.html)
