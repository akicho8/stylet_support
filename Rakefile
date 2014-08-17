# -*- coding: utf-8 -*-
require "bundler"
Bundler::GemHelper.install_tasks

require "rake/testtask"
Rake::TestTask.new do |t|
  t.libs << "test"
end

task :default => :test
