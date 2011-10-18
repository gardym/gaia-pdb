role :web, "vagrant"                          # Your HTTP server, Apache/etc
role :app, "vagrant"                          # This may be the same as your `Web` server
role :db,  "vagrant", :primary => true        # This is where Rails migrations will run

set :rails_env, "prototype"