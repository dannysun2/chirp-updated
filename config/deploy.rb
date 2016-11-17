set :application, 'chirpster'
set :repo_url, 'git@github.com:dannysun2/chirp-updated.git'

set :deploy_to, "/home/deploy/apps/#{fetch(:application)}"
set :keep_releases,   5
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :ssh_options, {
    forward_agent: true,
    port: 22
}
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
