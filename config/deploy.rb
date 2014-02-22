require 'mina/bundler'
require 'mina/git'
require 'mina/rvm'

set :user, 'root'
set :domain, 'pivoban.torial.com'
set :deploy_to, '/data/dev/www/pivoban'
set :repository, 'git@github.com:phillipoertel/pivoban.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, %w(log)

# This task is the environment that is loaded for most commands, such as
# `mina deploy` or `mina rake`.
task :environment do
  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use[ruby-1.9.3@pivoban]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
task :setup => :environment do
  queue! %[mkdir -p "#{deploy_to}/shared/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/log"]

  queue! %[mkdir -p "#{deploy_to}/shared/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/shared/config"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do

  # all of this runs in a temporary build directory
  # like /data/dev/www/pivoban/tmp/build-139308935028704
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'

    queue! %[mkdir -p tmp]

    queue! %[echo `ls -lah`]
    queue! %[bundle exec whenever --update-crontab]

    to :launch do
      queue "touch #{deploy_to}/current/tmp/restart.txt"
    end

    # This optional block defines how a broken release should be cleaned up.
    to :clean do
      queue 'log "failed deployment"'
    end
  end
end

# For help in making your deploy script, see the Mina documentation:
#
#  - http://nadarei.co/mina
#  - http://nadarei.co/mina/tasks
#  - http://nadarei.co/mina/settings
#  - http://nadarei.co/mina/helpers

