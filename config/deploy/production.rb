set :stage, :production

set :rails_env, "production" #added for delayed job
set :thinking_sphinx_roles, :app

# Replace 127.0.0.1 with your server's IP address!
server '188.166.77.169', user: 'deploy', roles: %w{web app}