# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'sharetribe'
set :repo_url, 'git@github.com:thesubr00t/sharetribe.git'
set :branch, :francisca

set :deploy_to, '/home/deploy/sharetribe'

set :linked_files, %w{config/database.yml config/config.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :delayed_job_bin_path, 'script' # for rails 3.x

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
      invoke 'delayed_job:restart'
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

  after 'deploy:published', 'restart' do
    invoke 'delayed_job:restart'
  end
end

