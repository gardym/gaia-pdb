##
# Unicorn config at /var/www/unicorn/current/config/unicorn.rb
# Managed by Chef - Local Changes will be Nuked from Orbit (just to be sure)
##

# What ports/sockets to listen on, and what options for them.
listen '/tmp/.sock', :backlog => 64

working_directory '/var/www/gaia/current'

# What the timeout for killing busy workers is, in seconds
timeout 60

# Whether the app should be pre-loaded
preload_app false

# How many worker processes
worker_processes 4

# Where to drop a pidfile
pid '/var/www/gaia/current/tmp/pids/unicorn.pid'

# Where stderr gets logged
stderr_path '/var/log/unicorn/error.log'

# Where stdout gets logged
stdout_path '/var/log/unicorn/out.log'
