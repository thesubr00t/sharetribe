# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'eurobizz'
set :repo_url, 'git@github.com:thesubr00t/sharetribe.git'

set :deploy_to, '/home/deploy/eurobizz'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :delayed_job_server_role, :worker
set :delayed_job_args, "-n 2"

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end

after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'delayed_job:restart'
  end
end