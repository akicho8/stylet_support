#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
#
# 反動抑制機能
#
# レバー反動抑制のしくみ
#
#   1. R だけに 4 フレーム以下入り、
#   2. ニュートラル状態を 2 フレーム以下で通過し、
#   3. 反対の L に入ったとき 1 フレーム間 L を無効にする
#
# ・上記説明の中で出てきたパラメータ 4 2 1 は、順番に、
#   side_frames, center_frames, suppression_frames にユーザーが設定する。
# ・L→ニュートラル→R の場合も同様である。
#
# アルゴリズム
#
# ・レバーの状態を表す文字列と、その状態を継続した時間を表すカウンタを一つの情報とし、配列に push していく
# ・配列サイズは2、つまり過去2つまで調べられればよい。
# ・状態が変化したら最新の状態(カウンタは更新する元の @state)を元に過去2つを調べ
#   抑制する必要があれば最新の状態の @state を無効にする
#
# その他メモ
#
# ・最初は InputUnit の update_all した後でこれを呼び to_s 値を元に調べ count を 0 にして無効にしていた。
#   しかし、それでは「上下が入っていれば左右を無効」する処理の後にこれを実行することになってしまい、
#   本当のレバー入力を元にチェックしていないことになってしまう。
#   したがって、update_all を呼ぶ前にこの処理を行わなくてはならない。
#   もちろん to_s で状態を調べて count = 0 で無効ではなく、新たに機能追加した state_to_s で調べて
#   state = false で無効にしなくてはならない。
#
class ReactionSuppression
  def initialize(target, side_frames = 4, center_frames = 2, suppression_frames = 1)
    set_target(target)
    set_param(side_frames, center_frames, suppression_frames)
  end

  def set_target(target)
    @target = target  # 抑制するInputUnitオブジェクト

    @old = ""         # 最初のレバー状態
    @history = []     # 状態移行履歴
    @count = 0        # 状態移行するまでの時間測定用
    @invoke = 0       # 指定したフレーム分抑制する
    @target_key = nil # 具体的な抑制対象方向
  end

  def set_param(side_frames, center_frames, suppression_frames)
    @side_frames = side_frames               # "r"に入れるフレーム数
    @center_frames = center_frames           # ニュートラル状態のフレーム数
    @suppression_frames = suppression_frames # "l"を無効にするフレーム数
  end

  def do_suppression
    if @old != @target.state_to_s             # レバーが前の状態から変化したか?
      @history << [@old, @count]              # 前の状態と前の状態であった時間を保存
      @history.shift until @history.size <= 2 # 履歴サイズの調整(2つあれば十分)
      @old = @target.state_to_s               # これからの状態を設定
      @count = 0                              # これからの状態をカウントするために初期化
                                              # 履歴情報を元に現在のレバー状態を無効にするべきか調べる
      check_activity("l", "r", :left) or      # "L" <= "" <= "R" の場合
        check_activity("r", "l", :right)      # "R" <= "" <= "L" の場合
    end
    @count += 1

    # 無効にするのが有効なら時間内だけ無効にする
    if @invoke >= 1
      @invoke -= 1
      @target.axis[@target_key].state = false # instance_eval{@count=0}ではない点に注意。
    end
  end

  def check_activity(prev0, prev2, key)
    state1, count1 = @history[-1]
    state2, count2 = @history[-2]
    if @target.state_to_s == prev0 &&                  # 現在 "L" で
        state1 == "" && count1 <= @center_frames &&    # 1つ前が ""(センター) で制限時間以内で
        state2 == prev2 && count2 <= @side_frames then # 2つ前が "R" で制限時間以内なら
      @invoke = @suppression_frames                    # 抑制発動
      @target_key = key                                # 抑制するキーの設定
      true
    else
      false
    end
  end

  def inspect
    out = ""
    out << "@history=" << @history.inspect << " "
    out << "@old=#{@old.inspect}(#{@count})"
  end

end

# 反動抑制機能付きモジュール
module ReactionSuppressionModule
  attr_reader :rs

  def initialize(*args)
    super
    @rs = ReactionSuppression.new(self)
  end

  def update_all
    @rs.do_suppression
    super
  end
end

if $0 == __FILE__
end
