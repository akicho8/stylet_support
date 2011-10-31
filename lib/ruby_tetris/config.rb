# -*- coding: utf-8 -*-
# 環境設定

require "ftools"

class ConfigHash < Hash
  def setup
    expand_values
    makedirs
    $LOAD_PATH << CONFIG[:modesdir] << CONFIG[:inputdir] << CONFIG[:sounddir] << File.dirname(File.expand_path(__FILE__))
    $LOAD_PATH.uniq!
  end

  private

  def makedirs
    [
      :datadir,
      :replaydir, :mpegdir,
      :simdir,
      :modesdir,
      :inputdir,
      :graphdir,
      :downdir,
      :sounddir,
    ].each{|e|
      begin
        File.makedirs(CONFIG[e], $DEBUG)
      rescue
        puts "mkdir #{CONFIG[e]}: failure" if false
      end
    }
  end

  def expand_values
    self.each_value{|val|
      config_expand(val)
    }
  end

  def config_expand(val)
    return val unless val.is_a? String
    val.gsub!(/\$\(([^()]+)\)/) {|var|
      key = $1.intern
      if self.key? key
        config_expand(self[key])
      else
        var
      end
    }
    val
  end
end

CONFIG = ConfigHash[
  {
    :version  => "1.0.0",
    :uri      => "druby://libretto:8470",

    :confdir  => File.dirname(File.expand_path(__FILE__)),

    # システム(消してはだめ)
    :simdir   => "$(confdir)/simulator",
    :modesdir => "$(confdir)/modes",
    :inputdir => "$(confdir)/input",
    # :sounddir => "$(confdir)/sound",

    # データ(消してもよい)
    :datadir   => "$(confdir)/_data",
    :replaydir => "$(datadir)/replay",
    :downdir   => "$(datadir)/replay/down",
    :mpegdir   => "$(datadir)/mpeg",
    :graphdir  => "$(datadir)/graph",
    :snapdir   => "$(datadir)/snapshot",

    :localdb   => true,         # ture=テスト用

    :mpeg_player => "mplayer",
    :mpeg_player_option => "-quiet",

    # :font      => "/usr/X11R6/lib/X11/fonts/TTF/luxirr.ttf",
    # :font      => "$(confdir)/luxirr.ttf",
    :font_size => 20,
    :joy_debug => true,

    :full_screen => false,

    # :screen_size => [320*1,240*1],
    # :mino_size  => [8*1,8*1],

    # :screen_size => [320*2,240*2],
    # :screen_size => [800,500],

    :screen_size => [320*2,240*2],
    :screen_size => [512,384],
    :mino_size  => [8*2-1,8*2-1],

    # :screen_size => [320*1, 240*1],
    # :mino_size  => [8*1, 8*1],
    #
    # :screen_size => [320/2, 240/2],
    # :mino_size  => [8/2, 8/2],


    :edge => :INSIDE,           # nil or :INSIDE or :OUTSIDE

    :dbserver => "libretto",
    :dbname => "local_tetris",
  }
]

# user_conf = Pathname("~/.tetrisrc").expand_path
# if user_conf.exist?
#   load test_conf
# end

# test_conf = Pathname(__FILE__).dirname.join("test.conf").expand_path
# if test_conf.exist?
#   load test_conf
# end

CONFIG.setup

if $0 == __FILE__
  p CONFIG
  p $LOAD_PATH
end
