role :web, "localhost"                          # Your HTTP server, Apache/etc
role :app, "localhost"                          # This may be the same as your `Web` server
role :db,  "localhost", :primary => true        # This is where Rails migrations will run

set :port, 2200
set :rails_env, "prototype"