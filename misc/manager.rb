#!/usr/local/bin/ruby -Ku
# Ruby/GTK+によるインターフェイス


require "gtk2"
require "kconv"
require "rubyext"

require "pp"

require "parsedate"
require "md5"
require "find"

require "config"

require "db_client"
require "recfile"
require "tool"
require "simulator"
require "input"
require "graph"

require "signal_observer"
require "with_sound"

require "load_all"

require "gtk2"
require "kconv"

require "rubyext"
require "observer"

module Gtk
  class ItemFactory
    alias old_create_items create_items
    def create_items(array)
      begin
        old_create_items(array.flatten.unflatten(6))
      rescue
        pp array.flatten.unflatten(6)
        raise "メニュー情報は必ず6個の要素を含まなくてはいけない"
      end
    end
  end
end

=begin
基本クラス

  class MyGtk::BaseWindow < Gtk::Window
  class MyGtk::BaseCList  < Gtk::CList

=end

module MyGtk
  class BaseWindow < Gtk::Window
  end

  class BaseCList
#     attr_reader :scrwin, :titles

#     include Observable
#     def initialize(titles)
#       @titles = titles

#       # カラム名の登録
#       # カラムの数だけ各カラムの「型」を引数に並べる
#       @ls = Gtk::ListStore.new(*([String] * @titles.size))
#       @tree_view = Gtk::TreeView.new(@ls)
#       @titles.each_with_index{|title, index|
#         column = Gtk::TreeViewColumn.new(title, Gtk::CellRendererText.new, {:text => index})
#         @tree_view.append_column(column)
#       }

#       # スクロールバー
#       @scrwin = Gtk::ScrolledWindow.new
#       @scrwin.add(@tree_view)
#       @scrwin.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)

#       # レコードがカーソルが動かされたり、選択されたりしたときに呼ばれる
#       selection.signal_connect('changed') do
#         iter = selection.selected
#         changed
#         if iter # 終了時にはnilになることもある
#           p iter.get_value(2) #=> :secretのデータが表示される
#           notify_observers(iter)
#         end
#       end
#       self.add_observer(self)
#     end
  end
end

# from rbbr.rb
module GtkExt

  def select_file(title="select file")
    fs = Gtk::FileSelection.new(title)
    fs.set_modal(true)
    filename = nil
    fs.signal_connect("destroy") do
      Gtk.main_quit
    end
    fs.ok_button.signal_connect("clicked") do
      fs.hide
      filename = fs.get_filename
      fs.destroy
    end
    fs.cancel_button.signal_connect("clicked") do
      fs.hide
      fs.destroy
    end
    fs.show_all
    Gtk.main
    filename
  end
  module_function(:select_file)

  def show_message(message)
    dialog = Gtk::Dialog.new
    dialog.set_title("message")
    dialog.set_modal(true)

    label = Gtk::Label.new(message)
    # label.jtype = Gtk::JUSTIFY_FILL
    # label.set_line_wrap(true)
    label.set_padding(10, 10)
    dialog.vbox.pack_start(label)

    button = Gtk::Button::new("OK")
    button.flags |= Gtk::Widget::CAN_DEFAULT
    dialog.action_area.pack_start(button)
    button.grab_default

    dialog.signal_connect("destroy") do Gtk.main_quit end
    button.signal_connect("clicked") do dialog.destroy end

    dialog.show_all
    Gtk.main
    nil
  end
  module_function(:show_message)

  def show_about(about)
    dialog = Gtk::Dialog.new
    dialog.set_title("about")
    dialog.set_modal(true)

    label = Gtk::Label.new(about)
    label.set_padding(10, 10)
    dialog.vbox.pack_start(label)

    button = Gtk::Button::new("OK")
    button.flags |= Gtk::Widget::CAN_DEFAULT
    dialog.action_area.pack_start(button)
    button.grab_default

    dialog.signal_connect("destroy") do Gtk.main_quit end
    button.signal_connect("clicked") do dialog.destroy end

    dialog.show_all
    Gtk.main
    nil
  end
  module_function(:show_about)

  def input_line(title, orig="")
    result = orig

    dialog = Gtk::Dialog.new
    dialog.set_title(title)
    dialog.set_modal(true)

    #    label = Label.new(message)
    #    label.jtype = JUSTIFY_FILL
    #    label.set_line_wrap(true)
    #    label.set_padding(10, 10)
    #    dialog.vbox.pack_start(label)
    entry = Gtk::Entry.new
    entry.set_text(orig)
    dialog.vbox.pack_start(entry)

    button = Gtk::Button::new("OK")
    button.flags |= Gtk::Widget::CAN_DEFAULT
    dialog.action_area.pack_start(button)
    button.grab_default

    dialog.signal_connect("destroy") do Gtk.main_quit end
    button.signal_connect("clicked") do
      result = entry.get_text
      dialog.destroy
    end

    dialog.show_all
    Gtk.main
    result
  end
  module_function(:input_line)

end

module GnomeExt
  module_function
  def message_box_sample(msg)
    window = Gtk::Window.new
    messagebox = Gnome::MessageBox.new("Are you OK?\nSecond line",
                                       Gnome::MessageBox::QUESTION,
                                       Gnome::Stock::BUTTON_YES,
                                       Gnome::Stock::BUTTON_NO,
                                       Gnome::Stock::BUTTON_CANCEL,
                                       Gnome::Stock::BUTTON_HELP)
    messagebox.set_modal(true)
    messagebox.set_transient_for(window)
    result = messagebox.run
    messagebox.destroy
    case(result)
    when 0
      p "YES"
    when 1
      p "NO"
    when 2
      p "CANCEL"
    when 3
      p "HELP"
    end
  end

  def __message_box(*args)
    window = Gtk::Window.new
    obj = Gnome::MessageBox.new(*args)
    obj.set_modal(true)
    obj.set_transient_for(Gtk::Window.new)
    result = obj.run
    obj.destroy
    result
  end

  def message_box_info(msg)
    __message_box(msg,
                  Gnome::MessageBox::INFO,
                  Gnome::Stock::BUTTON_OK) == 0
  end

  def message_box_warning(msg)
    __message_box(msg,
                  Gnome::MessageBox::WARNING,
                  Gnome::Stock::BUTTON_OK) == 0
  end

  def message_box_error(msg)
    __message_box(msg,
                  Gnome::MessageBox::ERROR,
                  Gnome::Stock::BUTTON_OK) == 0
  end

  def message_box_question(msg)
    __message_box(msg,
                  Gnome::MessageBox::GENERIC,
                  Gnome::Stock::BUTTON_OK,
                  Gnome::Stock::BUTTON_CANCEL) == 0
  end

  def message_box(msg)
    __message_box(msg,
                  Gnome::MessageBox::GENERIC,
                  Gnome::Stock::BUTTON_OK) == 0
  end


end

=begin

--------------------------------------------------------------------------------
このファイルの class/module の記述順序
--------------------------------------------------------------------------------

Recファイルのリスト

  class RecListWindow < BaseWindow
  class ReplayDataTable  < MyGtk::BaseCList

Recファイル一つのセクション情報

  class SectionWindow < BaseWindow
  class SectionCList  < MyGtk::BaseCList

トレーニングモード

  class TrainWindow   < BaseWindow
  class TrainCList    < MyGtk::BaseCList

その他

  module Facade
  class Manager


--------------------------------------------------------------------------------
注意点
--------------------------------------------------------------------------------

メニュー生成時のアイテムで proc{} の指定ができる部分を nil にしていると
環境よってはGtkが落ちてしまった。
対処方法は proc{} を常に指定しておくようにする。

BRANCHの場合、子のアイテムがある場合に書く必要がない。
また play_proc どうのこうのという警告がでることがある。
だから書かないほうがよさそうだ。
# ["/スタート(_S)", nil, Gtk::ItemFactory::BRANCH, nil, nil],

--------------------------------------------------------------------------------
TIPS
--------------------------------------------------------------------------------
=end

module TM
  REMOVEABLE_MENUBAR = false

  ################################################################################
  # Recファイルのリスト
  ################################################################################

  class RecListWindow < MyGtk::BaseWindow
    attr_reader :vpane, :modes_menu, :ifp, :entry

    def initialize
      super(Gtk::Window::TOPLEVEL)

      set_default_size(800, 600)
      signal_connect("destroy") {|*args|Gtk::main_quit}

      accel = Gtk::AccelGroup.new
      self.add_accel_group(accel)

      ManagerUtil.load_all
      @modes_menu = ManagerUtil::MyRadio.new(Modes, "/モード(_M)")
      @player_menu = ManagerUtil::PlayerMenu.new
      @train_menu = make_train_menu

      @ifp = Gtk::ItemFactory.new(Gtk::ItemFactory::TYPE_MENU_BAR, "<main>", accel)
      @ifp.create_items(menu_items)

      @modes_menu.set_item_factory(@ifp)
      @player_menu.set_item_factory(@ifp)

      # default setting
      @modes_menu.set_active(Modes::FrameMaster::Name)
      @player_menu.set_default

      # external command check
      @mpeg_env = Tool.possible_mpeg_play? && Tool.possible_mpeg_convert?

      # online check
      @client = TetrisClient.new
      check_sensitive_online

      #
      # +------- window -------+
      # |         menu         |
      # +----------------------+vbox
      # |        scw2          |
      # |       (clist)        |1
      # +----------------------+vpane
      # |         scr3         |2
      # |       (clist)        |
      # |                      |
      # +----------------------+
      # |        label         |
      # +----------------------+
      #
      # (window (vbox menu
      #               (vpane (scw2 clist)
      #                      (scw3 clist)))))
      #

      # menu + (tree+clist)
      vbox = Gtk::VBox.new(false, 0)
      add(vbox)

      # menu
      menubar = @ifp.get_widget("<main>")
      if REMOVEABLE_MENUBAR
        handlebox = Gtk::HandleBox.new
        handlebox.add(menubar)
        vbox.pack_start(handlebox, false, false, 0)
      else
        vbox.pack_start(menubar, false, false, 0)
      end

      @vpane = Gtk::VPaned.new
      vbox.pack_start(@vpane)

      # clist
      @replay_data_table = ReplayDataTable.new(self)
      scrolled_window = Gtk::ScrolledWindow.new
      scrolled_window.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
      scrolled_window.add(@replay_data_table)

      @vpane.add1(scrolled_window) # scw2

      # @vpane.add2(Gtk::Text.new) # なんでも良い

      # http://home2.highway.ne.jp/mutoh/tips/paned.html#1
      @vpane.set_position(250)

      @entry = Gtk::Entry.new
      @entry.set_text("")
      @entry.set_editable(false)
      vbox.pack_start(@entry, false, false, 0)

      @replay_data_table.update2
      show_all
    end

    def view_section(recfile, i)
      # 前のを消す
      @vpane.remove(@vpane.child2) if @vpane.child2
      # 新しいのを登録
      @vpane.add2(SectionFactory.new(self, recfile, i).vbox)
      show_all
    end

    # 注意事項
    # modes_menu などは階層構造になっているため flatten する必要がある。
    # だが flatten してしまうとメニュー情報の最小単位が配列なので、情報のまとまりの区別が付かなくなる。
    # だからメニュー情報は必ず6個の要素を持つようにして6個ずつ配列にする。
    # Gtk::Stock::NEW
    def menu_items
      [
["/ファイル(_F)",nil,nil,nil,proc{},nil],
["/ファイル(_F)/Tearoff1",                  Gtk::ItemFactory::TEAROFF,nil,nil,proc{},nil],
["/ファイル(_F)/スタート",                  Gtk::ItemFactory::ITEM,"<control>N",nil,proc{play_proc},nil],
["/ファイル(_F)/リプレイ",                  Gtk::ItemFactory::ITEM,"<control>R",nil,proc{@replay_data_table.replay_proc},nil],
#["/ファイル(_F)/詳細表示POPUP",            Gtk::ItemFactory::ITEM,"<control>I",nil,nil,proc{@replay_data_table.secwin_proc},nil],
["/ファイル(_F)/",                          Gtk::ItemFactory::SEPARATOR,nil,nil,proc{},nil],
["/ファイル(_F)/MPEG変換",                  Gtk::ItemFactory::ITEM,"<control>C",nil,proc{@replay_data_table.mpeg_conv_proc},nil],
["/ファイル(_F)/MPEG再生",                  Gtk::ItemFactory::ITEM,"<control>P",nil,proc{@replay_data_table.mpeg_play_proc},nil],
["/ファイル(_F)/",                          Gtk::ItemFactory::SEPARATOR,nil,nil,proc{},nil],
["/ファイル(_F)/その他/アップロード(全部)", Gtk::ItemFactory::ITEM,nil,nil,proc{upload_all},nil],
["/ファイル(_F)/",                          Gtk::ItemFactory::SEPARATOR,nil,nil,proc{},nil],
["/ファイル(_F)/閉じる",                    Gtk::ItemFactory::ITEM,"<control>Q",nil,proc{Gtk.main_quit},nil],
@modes_menu,
@player_menu,
#        ["/プレビュー表示", Gtk::ItemFactory::ITEM, "<control>P", nil, proc{@replay_data_table.view_last},nil],
#        ["/詳細表示", Gtk::ItemFactory::ITEM, "<control>I", nil, proc{@replay_data_table.selects.each{|recfile, i|@scont.reinit(recfile, i)}},nil],
#        ["/セクション表示", Gtk::ItemFactory::ITEM, "<control>I", nil, proc{@replay_data_table.selects.each{|recfile, i| view_section(recfile, i)}},nil],
#        ["/更新",     Gtk::ItemFactory::ITEM, "<control>U", nil, proc{@replay_data_table.update2},nil],
        ["/アップロード(_U)",  Gtk::ItemFactory::ITEM, "<control>U", nil, proc{@replay_data_table.upload},nil],
        ["/ダウンロード(_D)",  Gtk::ItemFactory::ITEM, "<control>D", nil, proc{download_all},nil],
        @train_menu,
        ["/ヘルプ(_H)/用語集",Gtk::ItemFactory::ITEM,nil,nil,proc{
            Tool.open_url("http://homepage3.nifty.com/tgm/yougo.html")
          },nil],
        ["/ヘルプ(_H)/About",Gtk::ItemFactory::ITEM,nil,nil,proc{show_about},nil],
      ]
    end

    def check_sensitive_online
      [
        "<main>/ファイル(F)/その他/アップロード(全部)",
        "<main>/ダウンロード(D)",
      ].each{|e|@ifp.get_widget(e).set_sensitive(@client.online?)}
    end

    def check_sensitive
      [
        "<main>/ファイル(F)/リプレイ",
      ].each{|e|@ifp.get_widget(e).set_sensitive(!@replay_data_table.selects.empty?)}

      [
        "<main>/アップロード(U)",
      ].each{|e|@ifp.get_widget(e).set_sensitive(!@replay_data_table.selects.empty? && @client.online?)}

      [
        "<main>/ファイル(F)/MPEG変換",
        "<main>/ファイル(F)/MPEG再生",
      ].each{|e|@ifp.get_widget(e).set_sensitive(!@replay_data_table.selects.empty? && @mpeg_env)}

    end

    # 指定ファイルをまとめてアップロードする
    def upload_files(select_files)
      (Message.file_put_empty; return) if select_files.empty?

      return unless Message.upload?(select_files) # 「これらのファイルをアップロードするか?」
      client = TetrisClient.new

      # 最初にチェックせずに client.db_file_list を取得しておいてループ中にチェックする方法もある。
      upfiles = client.possible_put_files(select_files)
      already_upfiles = select_files - upfiles

      client.put_files(*upfiles){|f,i|
        @entry.set_text("[#{i.succ}/#{select_files.size}] #{f} をアップロード中です。")
        Gtk.main_iteration while Gtk.events_pending?
        sleep(1) if false
      }
      @entry.set_text ""
      Message.uploaded(upfiles, already_upfiles)
    end

    private

    def make_train_menu
      training_proc = proc{|fname, widget|TrainWindow.new(fname)}
      files = Dir[File.join(CONFIG[:simdir], "*" + ".rb")]
      files.sort.collect{|fname|
        name = File.basename(fname, ".rb")
        # name = Kconv::toeuc(name)
        ["/シミュレータ(_S)/#{name}",Gtk::ItemFactory::ITEM,nil,nil,training_proc,fname]
      }.unshift ["/シミュレータ(_S)/Tearoff1",Gtk::ItemFactory::TEAROFF,nil,nil,proc{},nil]
    end

    ################################################################################

    def play_proc
      # モード選択の取得
      mode_klass = @modes_menu.active_class

      # 入力クラスの取得
      input_classes = @player_menu.active_classes

      # 入力クラスをセットして起動
      frame = mode_klass.new
      frame.players.each_with_index{|pl,i|
        pl.input = input_classes[i].new
      }

      gui = UI::DrawAll.new(frame)
      # gui = UI::DrawAll.new(frame)
      wave = nil
      music = nil
      frame.players.each{|player|
        SignalRecoder.new(player.controller) if defined? SignalRecoder
        wave = WavePlayer.new(player.controller) if defined? WavePlayer
        music = MusicPlayer.new(player.controller) if defined? MusicPlayer

      }
      frame.start(60){Gtk.main_iteration while Gtk.events_pending?}
      gui.close
      wave.close if wave
      music.close if music

      ManagerUtil.frame_save(frame)
      @replay_data_table.update2
    end

    def upload_all
      upload_files(TetrisClient.file_list2)
    end

    def download_all
      client = TetrisClient.new
      files = client.possible_get_files
      (Message.file_get_empty; return) if files.empty?
      return unless Message.download?(files)
      client.get_files(*files){|f|
        @entry.set_text("#{f} downloading...")
        Gtk.main_iteration while Gtk.events_pending?
      }
      @entry.set_text("")
      Message.downloaded(files)
      @replay_data_table.update2
    end

    def show_about
      about = [
        "TETRiS #{CONFIG[:version]}\n",
        "Ruby #{RUBY_VERSION}",
        "Gtk #{Gtk::VERSION.join('.')}",
        "Ruby/Gtk #{Gtk::BINDING_VERSION.join('.')}",
        "Ruby/SDL #{SDL::VERSION} (#{UI::Sdl.spec.join("/")})\n",
        "Network #{@client.online? ? "online" : "offline"}",
        "MPlayer #{@mpeg_env ? "exist" : "not exist"}",
      ].join("\n")
      GtkExt.show_about(about)
    end

  end

  class ReplayDataTable < Gtk::TreeView
    attr_reader :titles

    include Observable
    def initialize(win)
      @win = win
      super()

      @titles = ["モード", "グレード", "タイム", "レベル", "スコア", "プレイヤー", "プレイヤー番号", "ユーザ", "プレイ日時", "ファイル名"]
      @file_name_index = @titles.size
      @file_name_index2 = @file_name_index + 1

      # カラム名の登録
      # カラムの数だけ各カラムの「型」を引数に並べる

      model_args = Array.new(@titles.size, String) + [String, String]
      self.model = Gtk::ListStore.new(*model_args)
      @titles.each_with_index{|title, index|
        column = Gtk::TreeViewColumn.new(title, Gtk::CellRendererText.new, {:text => index})
        append_column(column)
      }

      # 自分自身が監視する
      add_observer(self)

      # レコードがカーソルが動かされたり、選択されたりしたときに呼ばれる
      selection.signal_connect('changed') do
        iter = selection.selected
        changed
        if iter # 終了時にはnilになることもある
          notify_observers(iter)
        end
      end
    end

    def update(iter)
      @win.view_section(*selects.first)
    end

    def selects
      iter = selection.selected
      [
        [iter.get_value(@file_name_index), iter.get_value(@file_name_index2).to_i],
      ]
    end

    def select_files
      selects.collect{|f,i|f}.uniq
    end

    def view_last
      select_files.each{|f|
        RecFile.open(f).view_last(UI::Sdl::Draw.instance)
      }
    end

#     def upload
#       @win.upload_files(select_files)
#     end

    # リプレイディレクトリを走査してファイル情報をCListに反映する。
    def update2

      # dir = File.join(CONFIG[:replaydir], @win.modes_menu.active_class(@win.ifp).name)
      @pool = []              # set_row_data したオブジェクトがGCで捨てられないようにするためにこっちにも入れておく。
      Find.find(CONFIG[:replaydir]){|recfile|
        if /\.rec$/ =~ recfile
          RecFile.open(recfile).summary.each_with_index{|row, i|
            iter = self.model.append
            row += [recfile, i]
            row.each_with_index{|column, column_index|
              iter[column_index] = column.to_s
            }
            @pool << [recfile, i]
          }
        end
      }
    end

#     def recfile_to_mpeg(fname)
#       File.join(CONFIG[:mpegdir], File.basename(fname, ".rec") + ".mpg")
#     end

    ################################################################################

    def replay_proc
      selects.each{|recfile, i|RecFile.open(recfile, i).replay_first}
    end

    def secwin_proc
      selects.each{|recfile, i|SectionWindow.new(recfile, i)}
    end

    # 選択されているけどMPEG化されていないファイル達
    def non_converted_files
      select_files.find_all{|f|!File.exist?(recfile_to_mpeg(f))}
    end

    def mpeg_conv_proc
      files = non_converted_files
      (Message.mpeg_all_converted(select_files); return true) if files.empty?
      return false unless Message.mpeg_make?(files)

      converted_files = []
      files.each{|f|
        mpegfile = recfile_to_mpeg(f)
        @win.entry.set_text "#{File.basename(f)} convert..."
        RecFile.open(f).mpeg_convert(mpegfile)
        converted_files << f if File.exist?(mpegfile)
      }
      @win.entry.set_text ""
      Message.mpeg_maked(converted_files)

      faild_files = files - converted_files
      unless faild_files.empty?
        Message.mpeg_failed(faild_files)
        return false
      end
      true
    end

    def mpeg_play_proc
      unless non_converted_files.empty?
        return unless mpeg_conv_proc
      end

      select_files.each{|f|
        mpegfile = recfile_to_mpeg(f)
        Tool.mpeg_player(mpegfile)
      }
    end

    ################################################################################

    def check_sensitive
      @win.check_sensitive
    end
  end


  ################################################################################
  # Recファイル一つのセクション情報
  ################################################################################

  class SectionWindow < MyGtk::BaseWindow
    attr_reader :ifp, :player_menu

    def initialize(fname, player_no=0)
      super()
      set_default_size(550, 300)
      set_title(File.basename(fname))
      @scont = SectionFactory.new(self, fname, player_no)
      add(@scont.vbox)
      show_all
    end
  end

  class SectionFactory
    attr_reader :ifp, :player_menu, :vbox
    def initialize(win, fname, player_no=0)
      @win = win
      @vbox = Gtk::VBox.new()
#       @accel = Gtk::AccelGroup.new
#       @accel.attach(@win)
      reinit(fname, player_no)
    end

    def reinit(fname, player_no=0)
      @player_menu = ManagerUtil::PlayerMenu.new(RecFile.open(fname).get_players.size, "/プレイヤー")

      @ifp = Gtk::ItemFactory.new(Gtk::ItemFactory::TYPE_MENU_BAR, "<main>", @accel)
      @ifp.create_items(
[
["/区間リプレイ", Gtk::ItemFactory::ITEM,nil,nil,proc{cur_clist.run_play_sample},nil],
["/グラフ表示/区間タイム",Gtk::ItemFactory::ITEM,nil,nil,proc{Facade.graph(Graph::GraphSection, fname, @notebook.get_current_page)},nil],
["/グラフ表示/消去ブロック",Gtk::ItemFactory::ITEM,nil,nil,proc{Facade.graph(Graph::GraphBlock, fname, @notebook.get_current_page)},nil],
["/スタート",Gtk::ItemFactory::ITEM,nil,nil,proc{cur_clist.run_play},nil],
@player_menu,
])

      @player_menu.set_item_factory(@ifp)
      @player_menu.set_default

      @menubar = ifp.get_widget("<main>")
      if REMOVEABLE_MENUBAR
        handlebox = Gtk::HandleBox.new
        handlebox.add(@menubar)
        @vbox.pack_start(handlebox, false, false, 0)
      else
        @vbox.pack_start(@menubar, false, false, 0)
      end

      @notebook = Gtk::Notebook.new()
      @section_views = RecFile.open(fname).get_players.enum_with_index.collect{|player, i|
        clist = SectionCList.new(fname, i, self)

        scrolled_window = Gtk::ScrolledWindow.new
        scrolled_window.set_policy(Gtk::POLICY_AUTOMATIC, Gtk::POLICY_AUTOMATIC)
        scrolled_window.add(clist)

        @notebook.append_page(scrolled_window, Gtk::Label.new("プレイヤー#{i.succ}"))
        clist
      }
      @vbox.add(@notebook)
      @notebook.show_all
      @notebook.set_page(player_no) # show_all後でないと変更できない点に注意
      check_sensitive

      # win.show_all
    end

    def cur_clist
      @section_views[@notebook.page]
    end

    def check_sensitive
      if @section_views
        [
          "<main>/区間リプレイ",
          "<main>/スタート",
        ].each{|e|@ifp.get_widget(e).set_sensitive(!cur_clist.selects.empty?)}
      end

      useful = Tool.gnuplot_useful?
      [
        "<main>/グラフ表示/区間タイム",
        "<main>/グラフ表示/消去ブロック",
        # "<main>/グラフ表示", # メニューの元を no sensitive にすることは不可能なようだ。
      ].each{|e|@ifp.get_widget(e).set_sensitive(useful)}
    end

  end

  # 2Pの時、2つ生成される。
  class SectionCList < Gtk::TreeView

    include Observable
    def initialize(fname, player_no, win)
      super()

      @rec = RecFile.open(fname, player_no)
      @win = win
      @titles = %w(レベル 合計タイム 区間タイム グレード 消去順 1 2 3 4 総数 ロスタイム スコア)
      @file_name_index = @titles.size

      model_args = Array.new(@titles.size, String) + [String, String]
      self.model = Gtk::ListStore.new(*model_args)
      @titles.each_with_index{|title, index|
        column = Gtk::TreeViewColumn.new(title, Gtk::CellRendererText.new, {:text => index})
        append_column(column)
      }

      # 自分自身が監視する
      add_observer(self)

      # レコードがカーソルが動かされたり、選択されたりしたときに呼ばれる
      selection.signal_connect('changed') do
        iter = selection.selected
        changed
        if iter # 終了時にはnilになることもある
          notify_observers(iter)
        end
      end

      # set_selection_mode(Gtk::SELECTION_SINGLE)
      update2
    end

    def update2
      iter = self.model.append
      @rec.sections.each_with_index{|e, i|
        row = e + [i]
        row.each_with_index{|column, column_index|
          iter[column_index] = column.to_s
        }
      }
    end

    def update(iter)
      # @win.view_section(*selects.first)

      # if controller.is_a? Gdk::EventButton
      @win.check_sensitive
      @ui.close if @ui # ウィンドウを常に一つだけにする場合は有効にする
      frame = Frame.replay1(@rec.seginfo[selects.first])
      @ui = UI::DrawAll.new(frame)
      frame.safe_show
      @ui.pause             # 画面が消されるか q が押されるまで待つ
      @ui.close if @ui     # SDLの場合、画面は残る。
      @ui = nil
      # end
    end

    def run_play
      if @ui
        @ui.close
        @ui = nil
      end
      selects.each{|no|
        frame = MementFrame.replay_with_input(@rec.seginfo[no], @win.player_menu.active_classes)
        gui = UI::DrawAll.new(frame)
        frame.start(60){Gtk.main_iteration while Gtk.events_pending?}
        gui.close
        ManagerUtil.frame_save(frame)
      }
    end

    def run_play_sample
      selects.each{|no|@rec.replay_segment(no)}
    end

    def selects
      iter = selection.selected
      if iter
        [
          iter.get_value(@file_name_index).to_i,
        ]
      else
        []
      end
    end
  end

  ################################################################################
  # トレーニングモード
  ################################################################################

  class TrainWindow < MyGtk::BaseWindow
    def initialize(fname)
      super()
      set_default_size(600, 300)
      set_title(File.basename(fname, ".rb"))

      accel = Gtk::AccelGroup.new
      # accel.attach(self)
      self.add_accel_group(accel)


      ifp = Gtk::ItemFactory.new(Gtk::ItemFactory::TYPE_MENU_BAR, "<main>", accel)
      ifp.create_items(
                       [
                         ["/プレイ(_S)",Gtk::ItemFactory::ITEM,nil,nil,proc{@replay_data_table.run_play},nil],
                         ["/見本プレイ(_R)",Gtk::ItemFactory::ITEM,nil,nil,proc{@replay_data_table.run_play_sample},nil],
                         ["/関連URL(_U)",Gtk::ItemFactory::ITEM,nil,nil,proc{@replay_data_table.run_open_url},nil],
                         ["/再読み込み(_L)",Gtk::ItemFactory::ITEM,nil,nil,proc{@replay_data_table.run_reload},nil],
                       ])
      vbox = Gtk::VBox.new()
      add(vbox)
      menubar = ifp.get_widget("<main>")
      if REMOVEABLE_MENUBAR
        handlebox = Gtk::HandleBox.new
        handlebox.add(menubar)
        vbox.pack_start(handlebox, false, false, 0)
      else
        vbox.pack_start(menubar, false, false, 0)
      end

      ################################################################################
      # メニューへのアクセス方法
      # menubar.children                            #=> [item1,item2,item3]
      # menubar.children[0].get_name                #=> "<main>/プレイ(S)"
      # ifp.get_widget("<main>/プレイ(S)").get_name #=> "<main>/プレイ(S)"
      ################################################################################

      @replay_data_table = TrainCList.new(self, fname, ifp)
      vbox.add(@replay_data_table.scrwin)

      show_all
    end
  end

  class TrainCList < MyGtk::BaseCList
    attr_reader :scrwin
    def initialize(win, fname, ifp)
      @win = win
      @fname = fname
      @ifp = ifp

      super %w(番号 タイトル ツモ 難易度 見本 日付 作者 リンク 備考)

      @tree_view.signal_connect('row_activated') do |tree_view, path, column|
        p tree_view, path, column
        # row_activated_cb(tree_view.model, path)
      end

#       @tree_view.signal_connect("row_activated") {|widget, row, column, controller|
#         # p controller

# #       tree_view.signal_connect('row_activated') do |tree_view, path, column|
# #         row_activated_cb(tree_view.model, path)
# #       end


#         if controller.is_a? Gdk::EventButton
#           check_sensitive
#           get_row_data(row).view
#         end
#       }

      run_reload
    end

    def update
#       update_call{
#         @pool = []
#         @data_ary.each_with_index{|e, i|
#           append([i.succ.to_s] + e.to_a)
#           @pool << e
#           set_row_data(i, @pool.last)
#         }
#       }
    end

    def selects
      sels = []
      each_selection{|row|sels << get_row_data(row)}
      sels
    end

    def check_sensitive
      @ifp.get_widget("<main>/プレイ(S)").set_sensitive(!selects.empty?)
      @ifp.get_widget("<main>/見本プレイ(R)").set_sensitive(!!selects.find{|e|e.sample_exist?})
      @ifp.get_widget("<main>/関連URL(U)").set_sensitive(!!selects.find{|e|e.get_url})
    end

    def run_play
      selects.each{|e|e.start}
    end

    def run_play_sample
      selects.each{|e|e.start_auto}
    end

    def run_open_url
      selects.each{|e|e.open_url}
    end

    def run_reload
      @data_ary = Simulator.load_file(@fname)
      update
    end
  end

  module Facade
    module_function
    def graph(klass, fname, player_no)
      klass.new(RecFile.open(fname, player_no)).view(File.basename(fname,".rec"))
    end
  end

  ################################################################################
  class Manager
    def initialize
      Gtk.init
      # GtkUtil.font_setup
      # Gnome.init("TETRiS The Underground Master 2", "1.0.0")
      RecListWindow.new
      Gtk.main
    end
  end
end

module ManagerUtil
  module_function

  def frame_save(frame)
    dump = frame.to_marshal_binary
    dir = $1 if /(\w+)$/ =~ frame.class.name
    fname = File.join(CONFIG[:replaydir], dir, MD5.hexdigest(dump) + ".rec")

    dir = File.dirname(fname)
    Dir.mkdir(dir) unless File.directory? dir

    open(fname, "w"){|io|io.write(dump)}
    puts "write #{fname}"

    RecFile.store_db(CONFIG[:dbserver], CONFIG[:dbname], fname)
  end

  # 指定moduleと連携している変なラジオメニュー
  class MyRadio < Array

    def initialize(mod, root, ifp=nil)
      super()
      @mod = mod
      @root = root
      @ifp = ifp
      remake
    end

    # メニュー配列の作成
    def remake
      @menu_path_list = []
      self.clear
      attr = Gtk::ItemFactory::RADIO_ITEM
      # p attr
      names = @mod.constants.collect{|e|@mod.const_get(e)::Name}.sort
      names.each{|name|
        str = "#{@root}/#{name}"
        ary = [str,attr,nil,nil,proc{},nil] # gtk2 になって順番が変わった。
        attr = str.gsub(/_/, "")
        self << ary
        @menu_path_list << str.gsub(/_/, "")
      }
      self.unshift ["#{@root}/Tearoff1", Gtk::ItemFactory::TEAROFF, nil, nil, proc{}, nil]
    end

    def set_item_factory(ifp)
      @ifp = ifp
      set_tooltip
    end

    # 生成されたアイテムのグループを返す
    def group
      # @menu_path_list.collect{|e|@ifp.get_widget(e)}
      @ifp.get_item("<main>" + self[1].first.gsub(/_/, "")).group
    end

    # アクティブなテキストを返す
    def active_text
      group.find{|e|e.active?}.child.text
    end

    # アクティブなテキストに対応するクラスを返す
    def active_class
      @mod.const_get(@mod.constants.find{|c|@mod.const_get(c)::Name == active_text})
    end

    # 指定したテキストのアイテムを有効にする
    def set_active(text)
#       pp group.first.child.text
#       exit
#       pp group.first
#       exit
      radio = group.find{|e|e.child.text == text}
      radio.set_active(true) if radio
    end

    # ツールチップの設定
    def set_tooltip(on=true)
#       group.each{|e|
#         klass = @mod.const_get(@mod.constants.find{|c|@mod.const_get(c)::Name == e.child.text})
#         if klass.const_defined?(:Tooltip)
#           Gtk::Tooltips.new.set_tip(e, klass::Tooltip, nil).send(on ? :enable : :disable)
#         end
#       }
    end
  end

  class PlayerMenu < Array
    def initialize(num=4, root="/プレイヤー(_P)", ifp=nil)
      super()
      (1..num).each{|i|
        self << MyRadio.new(Players, "#{root}/#{i}P", ifp)
      }
    end

    def set_item_factory(ifp)
      each{|e|e.set_item_factory(ifp)}
    end

    def active_classes
      map{|e|e.active_class}
    end

    def set_tooltip(on=true)
      each{|e|e.set_tooltip(on)}
    end

    def set_default
      list = [Players::Player1, Players::Player2]
      each_with_index{|e,i|
        e.set_active(list[i % list.size]::Name)
      }
    end
  end
end

module Message
  module_function

  def file_put_empty
    GnomeExt.message_box "新規にアップロードできるファイルがありません。"
  end

  def file_get_empty
    GnomeExt.message_box "ダウンロードできるファイルがありませんでした。"
  end

  def upload?(files)
    GnomeExt.message_box_question "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルをアップロードします。"
  end

  def download?(files)
    GnomeExt.message_box_question "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルをダウンロードします。"
  end

  def already_uploaded(files)
    return if files.empty?
    GnomeExt.message_box "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルはアップロード済みでした。"
  end

  def uploaded(files, already_upfiles)
    msg = []
    unless already_upfiles.empty?
      msg << "#{already_upfiles.collect{|e|File.basename(e)+"\n"}}\n以上の#{already_upfiles.size}ファイルはアップロード済みでした。"
    end
    if files.empty?
      msg << "何もアップロードしませんでした。"
    else
      msg << "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルをアップロードしました。"
    end
    GnomeExt.message_box(msg.join("\n\n"))
  end

  def downloaded(files)
    GnomeExt.message_box "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルをダウンロードしました。"
  end

  def mpeg_make?(files)
    GnomeExt.message_box_question "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルをMPEG変換します。"
  end

  def mpeg_all_converted(files)
    GnomeExt.message_box "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルはすでに変換済みです。"
  end

  def mpeg_maked(files)
    GnomeExt.message_box "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルをMPEG変換しました。"
  end

  def mpeg_failed(files)
    GnomeExt.message_box "#{files.collect{|e|File.basename(e)+"\n"}}\n以上の#{files.size}ファイルのMPEG変換に失敗しました。"
  end
end

if $0 == __FILE__
  TM::Manager.new
end
