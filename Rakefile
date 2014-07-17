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

task :help do
  puts "Available rake tasks: "
  puts "rake console - Run a IRB console with all enviroment loaded"
  puts "rake spec - Run specs"
end

task :spec do
  desc "Run all specs with rcov"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = "spec/**/*_spec.rb"
  end
end

desc "Update all the data in data_factorydata/"
task :update_data do
require 'open-uri'
  names = %w(champions colombia espana libertadores mexico mundial peru premierleague)
  names.each do |name|
    puts "Processing #{name}"
    url = "http://www.datafactory.ws/clientes/xml/index.php?ppaass=Golazzos&canal=deportes.futbol.#{name}.equipos"
    open("lib/data_factory/data/deportes.futbol.#{name}.equipos.xml", "wb") {|file| file << open(url).read }
  end

end

task :default => [:spec]
