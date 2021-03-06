# config valid for current version and patch releases of Capistrano
lock '~> 3.14.1'

set :application, 'MinecraftServerCompendium'
set :repo_url, 'git@github.com:wamonroe/minecraft-server-compendium.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/srv/msc'

# Rbenv settings
set :rbenv_type, :user
set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefex, <<~RBP.split.join(' ')
  RBENV_ROOT=#{fetch(:rbenv_path)}
  RBENV_VERSION=#{fetch(:rbenv_ruby)}
  #{fetch(:rbenv_path)}/bin/rbenv exec
RBP

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto,
#   truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, '.rbenv-vars'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/packs', '.bundle',
  'node_modules'

# Default value for default_env is {}
# set :default_env, { path: '/opt/ruby/bin:$PATH' }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 3

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

before 'deploy:assets:precompile', 'deploy:clobber_assets'
after 'deploy:finished', 'deploy:restart_puma'

namespace :deploy do
  desc 'Restart Puma'
  task restart_puma: [:set_rails_env] do
    on roles(:app) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, 'exec pumactl -P /srv/msc/shared/tmp/pids/server.pid restart'
        end
      end
    end
  end
end
