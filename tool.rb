#!/usr/local/bin/ruby -Ku
# 各種外部プログラムのラッパー


require "config"

module Tool
  module_function

  # 指定コマンドがあるか?
  def command_exist?(command)
    !`which #{command} 2>/dev/null`.strip.empty?
  end

  # gnuplotがあるか?
  def gnuplot_useful?
    command_exist?("gnuplot")
  end

  # MPEG再生できるか?
  def possible_mpeg_play?
    command_exist?(CONFIG[:mpeg_player])
  end

  # MPEG変換できるか?
  def possible_mpeg_convert?
    command_exist?("mogrify") && command_exist?("mencoder")
  end

  # MPEG再生
  def mpeg_player(mpegfile)
    return false unless possible_mpeg_play?

    `#{CONFIG[:mpeg_player]} #{CONFIG[:mpeg_player_option]} #{mpegfile} >/dev/null 2>&1`
    true
  end

  # 複数のBMPからMPEGを作成
  def mpeg_convert(srcdir, output_mpeg, fps=60)
    return false unless possible_mpeg_convert?
    bmpfiles = File.join(srcdir, "*.bmp")
    `mogrify -format jpg #{bmpfiles}`
    Dir[bmpfiles].each{|f|File.delete(f)}
    File.delete(output_mpeg) if File.exist?(output_mpeg)
    File.makedirs(File.dirname(output_mpeg), $DEBUG) # 出力するディレクトリがない場合があるので作成しておく
    w, h = CONFIG[:screen_size]

    if false
      `mencoder -mf on:w=#{w}:h=#{h}:fps=#{fps} -ovc lavc -lavcopts vcodec=msmpeg4 -o #{output_mpeg} #{srcdir}/\*.jpg >/dev/null 2>&1`
    else
      # デバッグしやすいようにシェルスクリプトファイルを生成してから実行する。
      outfile = "_make_mpeg_" + File.basename(output_mpeg, ".mpg") + ".sh"
      File.open(outfile, "w"){|fh|
        fh.puts("#!/bin/sh")
        fh.puts("echo '#{output_mpeg}'")
        fh.puts("mencoder -mf on:w=#{w}:h=#{h}:fps=#{fps} -ovc lavc -lavcopts vcodec=msmpeg4 -o #{output_mpeg} #{srcdir}/\\*.jpg >/dev/null 2>&1")
      }
      File.chmod(0777, outfile)
      `#{File.expand_path(outfile)}`
    end

    if File.exist?(output_mpeg)
      puts "mencoder output: #{output_mpeg}" if $DEBUG
      true
    else
      raise "mencoder error: #{output_mpeg}" if $DEBUG
      false
    end
  end

  # 複数のMPEGを連結
  def mpeg_join(output_mpeg, mpeg_files)
    return false unless possible_mpeg_convert?

    tmpfile = output_mpeg + ".tmp"
    `cat #{mpeg_files.join(" ")} > #{tmpfile}`
    `mencoder -forceidx #{tmpfile} -oac copy -ovc copy -o #{output_mpeg} >/dev/null 2>&1`
    File.delete(tmpfile)

    puts "mpeg_join output #{output_mpeg}" if $DEBUG
    File.exist?(output_mpeg)
  end

  def __mpeg_add_audio(input_file, mp3_file, output_file)
    `avimerge -o #{output_file} -i #{input_file} -p #{mp3_file} >/dev/null 2>&1`
  end

  def mpeg_add_audio(fname, mp3file)
    return unless mp3file
    tmpfile = "#{fname}.orig"
    File.rename(fname, tmpfile)
    Tool.__mpeg_add_audio(tmpfile, mp3file, fname)
    File.delete(tmpfile)
    File.exist?(fname)
  end

  def open_url(url)
    return if url.to_s.empty?
    Thread.start{
      Thread.current.abort_on_exception = true
      command = if `ps | grep mozilla | wc -l`.strip.to_i == 0
                  "mozilla #{url}"
                else
                  "mozilla -remote \"openurl(#{url})\""
                end
      puts command if $DEBUG
      `#{command}`
    }
  end

end

if $0 == __FILE__
end
