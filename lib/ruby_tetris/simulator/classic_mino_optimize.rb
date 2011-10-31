#!/usr/local/bin/ruby -Ku

$LOAD_PATH << '..'
require "simulator"
require "optimize_helper"

class ClassicBlockControllOptimize
  def initialize
    @input_collection = {
      "l_B"   => %[l|     B   d_ *],
      "l_rB"  => %[l| r   B   d_ *],
      "lB"    => %[*  l         B   d_ *],
      "B"     => %[B*               d_ *],
      "rB"    => %[* r          B   d_ *],
      "rrB"   => %[* r . r      B   d_ *],
      "Br_"   => %[Br|    d_ *],

      "l_A"   => %[l|     A   d_ *],
      "l_rA"  => %[l| r   A   d_ *],
      "lA"    => %[* l         A   d_ *],
      "A"     => %[A*              d_ *],
      "rA"    => %[* r         A   d_ *],
      "rrA"   => %[* r . r     A   d_ *],
      "r_lA"  => %[r| l A   d_ *],
      "r_A"   => %[r|   A   d_ *],

      "l_AC"  => %[l|     A C d_ *],
      "l_rAC" => %[l|  r   A C d_ *],
      "lAC"   => %[* l         A C d_ *],
      "AC"    => %[A* C d_ *],
      "rAC"   => %[* r         A C d_ *],
      "rrAC"  => %[* r . r     A C d_ *],
      "r_lAC" => %[r| l A C d_ *],
      "r_AC"  => %[r|   A C d_ *],

      "l_"    => %[l|       d_ *],
      "l_r"   => %[l| r     d_ *],
      "l"     => %[* l             d_ *],
      "@"     => %[*               d_ *],
      "r"     => %[* r             d_ *],
      "rr"    => %[* r . r         d_ *],
      "r_l"   => %[r| l     d_ *],
      "r_"    => %[r|       d_ *],

      "ll"    => %[* l . l         d_ *],

      "r_B"   => %[r|   B   d_ *],
      "r_lB"  => %[r| l B   d_ *],

      "Al_"   => %[Al|     d_ *],
      "Al_r"  => %[Al| r   d_ *],
      "Ar_"   => %[Ar|     d_ *],
    }

    @mino_o = [
      ######################################## Yellow
      %w[yd0 l_],
      %w[yd1 l_r],
      %w[yd2 ll],
      %w[yd3 l],
      %w[yd4 @],
      %w[yd5 r],
      %w[yd6 rr],
      %w[yd7 r_l],
      %w[yd8 r_],
    ]

    @input_selection = @mino_o + [

      ######################################## Blue
      %w[bd1 l_],
      %w[bd2 l_r],
      %w[bd3 l],
      %w[bd4 @],
      %w[bd5 r],
      %w[bd6 rr],
      %w[bd7 r_l],
      %w[bd8 r_],

      %w[bl1 l_B],
      %w[bl2 l_rB],
      %w[bl3 lB],
      %w[bl4 B],
      %w[bl5 rB],
      %w[bl6 rrB],
      %w[bl7 r_lB],
      %w[bl8 r_B],
      %w[bl9 Br_],

      %w[bu1 l_AC],
      %w[bu2 l_rAC],
      %w[bu3 lAC],
      %w[bu4 AC],
      %w[bu5 rAC],
      %w[bu6 rrAC],
      %w[bu7 r_lAC],
      %w[bu8 r_AC],

      %w[br1 l_A],
      %w[br2 l_rA],
      %w[br3 lA],
      %w[br4 A],
      %w[br5 rA],
      %w[br6 rrA],
      %w[br7 r_lA],
      %w[br8 r_A],

      ######################################## Orange
      %w[od1 l_],
      %w[od2 l_r],
      %w[od3 l],
      %w[od4 @],
      %w[od5 r],
      %w[od6 rr],
      %w[od7 r_l],
      %w[od8 r_],

      %w[ol1 l_B],
      %w[ol2 l_rB],
      %w[ol3 lB],
      %w[ol4 B],
      %w[ol5 rB],
      %w[ol6 rrB],
      %w[ol7 r_lB],
      %w[ol8 r_B],
      %w[ol9 Br_],

      %w[ou1 l_AC],
      %w[ou2 l_rAC],
      %w[ou3 lAC],
      %w[ou4 AC],
      %w[ou5 rAC],
      %w[ou6 rrAC],
      %w[ou7 r_lAC],
      %w[ou8 r_AC],

      %w[or1 l_A],
      %w[or2 l_rA],
      %w[or3 lA],
      %w[or4 A],
      %w[or5 rA],
      %w[or6 rrA],
      %w[or7 r_lA],
      %w[or8 r_A],

      ######################################## Green
      %w[gd1 l_],
      %w[gd2 l_r],
      %w[gd3 l],
      %w[gd4 @],
      %w[gd5 r],
      %w[gd6 rr],
      %w[gd7 r_l],
      %w[gd8 r_],

      %w[gl1 l_B],
      %w[gl2 l_rB],
      %w[gl3 lB],
      %w[gl4 B],
      %w[gl5 rB],
      %w[gl6 rrB],
      %w[gl7 r_lB],
      %w[gl8 r_B],

      ######################################## Purple
      %w[pd1 l_],
      %w[pd2 l_r],
      %w[pd3 l],
      %w[pd4 @],
      %w[pd5 r],
      %w[pd6 rr],
      %w[pd7 r_l],
      %w[pd8 r_],

      %w[pl1 l_B],
      %w[pl2 l_rB],
      %w[pl3 lB],
      %w[pl4 B],
      %w[pl5 rB],
      %w[pl6 rrB],
      %w[pl7 r_lB],
      %w[pl8 r_B],

      ######################################## Cyan
      %w[cd1 l_],
      %w[cd2 l_r],
      %w[cd3 l],
      %w[cd4 @],
      %w[cd5 r],
      %w[cd6 rr],
      %w[cd7 r_l],
      %w[cd8 r_],

      %w[cl1 l_B],
      %w[cl2 l_rB],
      %w[cl3 lB],
      %w[cl4 B],
      %w[cl5 rB],
      %w[cl6 rrB],
      %w[cl7 r_lB],
      %w[cl8 r_B],
      %w[cl9 Br_],

      %w[cu1 l_AC],
      %w[cu2 l_rAC],
      %w[cu3 lAC],
      %w[cu4 AC],
      %w[cu5 rAC],
      %w[cu6 rrAC],
      %w[cu7 r_lAC],
      %w[cu8 r_AC],

      %w[cr1 l_A],
      %w[cr2 l_rA],
      %w[cr3 lA],
      %w[cr4 A],
      %w[cr5 rA],
      %w[cr6 rrA],
      %w[cr7 r_lA],
      %w[cr8 r_A],

      ######################################## Red
      %w[rd1  l_],
      %w[rd2  l_r],
      %w[rd3  l],
      %w[rd4  @],
      %w[rd5  r],
      %w[rd6  r_l],
      %w[rd7  r_],

      %w[rl-1 Al_],
      %w[rl0  Al_r],
      %w[rl1  l_A],
      %w[rl2  l_rA],
      %w[rl3  lA],
      %w[rl4  A],
      %w[rl5  rA],
      %w[rl6  r_lA],
      %w[rl7  r_A],
      %w[rl8  Ar_],
    ]
  end

  def make_data_ary
    controller = SimulateController.new(0.008)   # 2秒間に一段落下のスピード
    #    controller.level_info.fall_delay = nil # フィールドへの書き込み禁止
    InputSelection.collect{|key,value|
      _, _mino, _dir, _xpos = */(.)(.)([+-]?\d+)/.match(key)

      mino = Mino::Classic.create(_mino)
      mino.x = _xpos.to_i
      mino.dir.set(_dir)

      {
        :title => "#{mino.jcolor}色を#{mino.dir.jinspect}向きで#{OptimizeHelper.mino_width(mino).collect{|i|i.succ}.join(",")}列目に置く",
        :author => "GOO",
        :date => "2003-09-06",
        :url => "http://www.geocities.co.jp/SiliconValley-SanJose/4825/tet/",
        :difficulty => OptimizeHelper.to_difficulty_level_from_input_string(InputCollection[value]),
        :comment => "#{key}",
        :controller => controller,
        :pattern => _mino,
        :field => OptimizeHelper.make_hole_field(mino),
        :input => InputCollection[value],
      }
    }
  end
end

if $0 == __FILE__
  library = ClassicBlockControllOptimize.new.make_data_ary
  library.each{|e| break if Simulator.start_auto(e, 60) == :break}
  exit
  Simulator.start_auto(library[0],60)
  Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 10)
  Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 60)
end
