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

require File.expand_path(File.dirname(__FILE__) + '/environment')
set :path_env, ENV['PATH']
set      :job_template, "source $HOME/.zshrc; $(which zsh) -l -c ':job'"
job_type :rake, "source /Users/mitsuyashouta/.zshrc; export PATH=\"$HOME/.rbenv/bin:$PATH\"; eval \"$(rbenv init -)\"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output"
job_type :runner,       "cd :path && bundle exec rails runner -e :environment ':task' :output"
rails_env = ENV['RAILS_ENV'] || :development
set :output, "#{Rails.root}/log/cron.log"
set :environment, rails_env

every :friday, at: '12pm' do
  rake 'point_task:t_point_create'
  rake 'point_task:d_point_create'
  rake 'point_task:pay_point_create'
end
