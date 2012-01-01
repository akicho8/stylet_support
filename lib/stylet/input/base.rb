# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "../axis_support"))

module Stylet
  module Input
    Axis   = Struct.new(:up, :down, :left, :right)
    Button = Struct.new(:btA, :btB, :btC, :btD)

    #
    # このモジュールをプレイヤーや人工無能相当に直接includeしてaxisとbuttonの情報を持たせるようにする
    #
    module Base
      attr_reader :axis, :button

      def initialize(*)
        super if defined? super
        @axis = Axis.new(KeyOne.new("u"), KeyOne.new("d"), KeyOne.new("l"), KeyOne.new("r"))
        @button = Button.new(KeyOne.new("AL"), KeyOne.new("BR"), KeyOne.new("C"), KeyOne.new("D"))
      end

      #
      # 上下左右とボタンの状態を配列で返す
      #
      def key_objects
        @axis.values + @button.values
      end

      #
      # レバーの更新前のビット状態を取得
      #
      #   更新前であることに注意
      #
      def state_to_s
        @axis.values.collect{|e|e.state_to_s}.to_s
      end

      #
      # 適当に文字列化
      #
      def to_s(stype=nil)
        case stype.to_s
        when "axis"   then @axis.values.to_s
        when "button" then @button.values.to_s
        else
          key_objects.to_s
        end
      end

      #
      # 左右の溜めが完了しているか?(次の状態から使えるか?)
      #
      def key_power_effective?(power_delay)
        Input::Support.key_power_effective?(@axis.left, @axis.right, power_delay)
      end

      # #
      # # ここで各ボタンを押す
      # #
      # def update
      #   # raise NotImplementedError, "#{__method__} is not implemented"
      # end

      #
      # ボタンとレバーのカウンタを更新する
      #
      #   実行後に state は false になる
      #
      def key_counter_update_all
        key_objects.each{|e|e.update}
      end

      def axis_angle_index
        AxisSupport.axis_angle_index(@axis)
      end

      def axis_angle
        AxisSupport.axis_angle(@axis)
      end
    end
  end
end
