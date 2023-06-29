# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

## config/schedule.rb

# Rails.root(Railsメソッド)を使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")

# cronを実行する環境変数
# 環境変数ENV['RAILS_ENV']にセットされている変数または:developmentを指定
# 自分の環境でENV['RAILS_ENV']にすでにdevelopmentがセットされていた
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

# cron.logの出力先を指定している
# Rails.rootはこのアプリのルート階層が返される
set :output, "#{Rails.root}/log/cron.log"


every 1.minutes do
  rake 'point_task:t_point_create'
  rake 'point_task:d_point_create'
  rake 'point_task:pay_point_create'
end
