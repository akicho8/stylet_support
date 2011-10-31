# スコア計算
#
# 2001-02-26 ZONさん計算式組み込み
#
# level_count: lv 消す前のレベル
# line_count:  n  消したライン数
# up_cells:    u  レバー上で落下させた段数
# down_cells:  d1 レバー下で落下させた段数
# set_by_down: d2 接地状態からレバー下で接着させれば 1、なければ 0
#
# m_line_c:    c  コンボ開始から直前の消しまでの全ての消しについて、(2n-2)を累積して加算した値
#
class Score
  attr_accessor :verbose

  def initialize(verbose = false)
    @verbose = verbose
    reset
  end

  def chain_combo?
    @combo_count.nonzero?
  end

  # コンボ解除
  def reset
    @combo_count = 0
  end

  # スコア計算
  def compute(lv, n, u, d1, d2)
    base = (lv + n + 3) / 4 + (2*u + d1 + d2)
    mul = n * (2 * n - 1 + @combo_count)
    result = base * mul
    c = 2 * n - 2
    cc = @combo_count + c
    if @verbose
      puts "base=((#{lv}+#{n}+3)/4 + 2*#{u}+#{d1}+#{d2})=#{base}  " +
        "mul=(#{n} * (2*#{n}-1 + #{@combo_count}))=#{mul}  " +
        "#{base}*#{mul}=#{result}  " +
        "c=2*#{n}-2=#{c} " +
        "@combo_count=#{@combo_count}+#{c}=#{cc}"
    end
    @combo_count = cc
    result
  end
end

if $0 == __FILE__
  s = Score.new(true)
  s.reset
  s.compute(500,1,0,0,1)
  s.compute(500,2,0,0,1)
  s.compute(500,3,0,0,1)
  s.compute(500,4,0,0,1)
  s.compute(500,1,0,0,1)

  s.reset
  s.compute(500,4,0,0,1)
  s.compute(500,1,0,0,1)
  s.reset
  s.compute(500,1,0,0,1)
  s.compute(500,4,0,0,1)
end
