lock "~> 3.14.1"

set :application, "baukis2"

set :repo_url, "https://github.com/takahashi1987/baukis2.git"

set :deploy_to, "/var/www/rails/baukis2"

set :linked_files, fetch(:linked_files, []).push("config/settings.yml")

set :linked_dirs, fetch(:linked_dirs, []).push("log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system")

set :keep_releases, 5

set :rbenv_ruby, "2.6.4"

set :log_level, :debug

namespace :deploy do
  desc "Restart application"
  task :restart do
    invoke "unicorn:restart"
  end

  desc "Create database"
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, "db:create"
        end
      end
    end
  end

  desc "Run seed"
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, "db:seed"
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
