# -*- coding: utf-8 -*-
module Stylet
  module Input
    #
    # ボタン一つの情報を管理するクラス
    #
    #   state をセットして update することでカウンタが更新される
    #
    class KeyOne
      # キーリピート2としたときの挙動
      # 3フレーム目に押された場合
      #
      #        2 3 4 5 6 7 (frame)
      #  count 0 1 2 3 4 5
      # repeat 0 1 0 0 2 3
      #            ^ ^  の数(1と2の間がの数)がkey_repeat
      #
      def self.repeat(count, key_repeat)
        repeat = 0
        if count == 1
          repeat = 1
        elsif count > key_repeat + 1
          repeat = count - key_repeat
        else
          repeat = 0
        end
        repeat
      end

      attr_reader :mark, :count, :free_count
      # attr_accessor :state

      def initialize(mark = "?")
        @mark = mark.to_s.scan(/./) # "AR" だったら A と R に対応
        @count = 0
        @free_count = 0
        @state = false              # 直近のフラグ
      end

      #
      # 直近フラグを設定。falseにはできない。
      #
      def <<(arg)
        case arg
        when String
          if false
            arg = arg.include?(@mark)
          else
            arg = !!@mark.find{|m|arg.include?(m)}
          end
        when Fixnum
          arg = (arg != 0)
        end
        @state |= arg
      end

      #
      #  更新する前のon/off状態を取得(廃止予定)
      #
      def state_to_s
        @state ? mark.first : ""
      end

      #
      # @state の状態を @count に反映する
      #
      #   引数が指定されていればそれを直近の状態に設定して更新する
      #
      def update(state = nil)
        if state
          self << state
        end
        if @state
          @count += 1
          @free_count = 0
        else
          @count = 0
          @free_count += 1
        end
        @state = false
      end

      # キーリピート2としたときの挙動
      # 3フレーム目に押された場合
      #
      #        2 3 4 5 6 7 (frame)
      #  count 0 1 2 3 4 5
      # repeat 0 1 0 0 2 3
      #            ^ ^  の数(1と2の間がの数)がkey_repeat
      #
      def repeat(key_repeat = 12)
        self.class.repeat(@count, key_repeat)
      end

      #
      # 押されていない？
      #
      def free?
        @count == 0
      end

      #
      # 押しっぱなし？
      #
      def press?
        @count >= 1
      end

      #
      # 押した瞬間？
      #
      def trigger?
        @count == 1
      end

      #
      # 押していないとき 0.0 で押している間は 1.0 を返す
      #
      def repeat_0or1
        if repeat >= 1
          1.0
        else
          0.0
        end
      end

      #
      # 離した瞬間？
      #
      def free_trigger?
        @free_count == 1
      end

      #
      # 優先度チェック用
      #
      def <=>(other)                # sortで優先度の高い順に並べる為の比較処理
        if @count == 0 || other.count == 0
          other.count <=> @count    # 0はもっとも優先度が低い為逆にする
        else
          @count <=> other.count
        end
      end

      #
      # 指定のボタンと同時押し状態？
      #
      def ==(other)
        @count == other.count
      end

      #
      # 押されているときだけ自分のマークを返す
      #
      def to_s
        press? ? @mark.first : ""
      end
    end
  end
end
