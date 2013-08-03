# -*- coding: utf-8 -*-
require "bundler"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new
task :default => :spec
task :test => :spec

require "yard"
YARD::Rake::YardocTask.new

desc "examples/* の最低限の動作確認"
task :test_examples do
  system("cd examples && ruby test_all.rb")
end
