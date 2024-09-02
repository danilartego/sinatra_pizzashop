require "./app"
require "sinatra/activerecord/rake"

# Добавляем команду для запуска консоли. rake db:console
namespace :db do
  desc "Open an IRB session preloaded with the app"
  task :console do
    require 'irb'
    ARGV.clear
    IRB.start
  end
end