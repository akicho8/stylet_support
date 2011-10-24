require "rake/testtask"
require "rake/rdoctask"
require "reek/rake/task"

desc "すべてのテストを実行"
task :default => "test:units"

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << "test"
    t.test_files = FileList["test/units/test*.rb"]
    t.verbose = false
  end
end

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
end



namespace :doc do
  desc "ドキュメント生成"
  Rake::RDocTask.new("app") {|rdoc|
    rdoc.rdoc_dir = "doc/app"
    rdoc.title    = "RubyTetris ドキュメント"
    rdoc.options << "--line-numbers" << "--inline-source" << "--charset" << "UTF-8" << "--diagram" << "--image-format" << "png"
    rdoc.rdoc_files.include("doc/README")
    rdoc.rdoc_files.include("*.rb")
    rdoc.rdoc_files.include("mode/**/*.rb")
    # rdoc.rdoc_files.include("sample/**/*.rb")
  }
end

# Rake::RDocTask.new(:rdoc_dev) do |rd|
#   rd.main = "README.doc"
#   rd.rdoc_files.include("README.rdoc", "lib/**/*.rb")
#   rd.options << "--all"
# end

