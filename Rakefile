#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rspec/core/rake_task'
Bundler::GemHelper.install_tasks

desc "Run a IRB console with all enviroment loaded"
task :console do
  Rake::Task["build"].invoke
  Rake::Task["install"].invoke
  puts "Loading development console..."
  system("irb -r data_factory")
end
