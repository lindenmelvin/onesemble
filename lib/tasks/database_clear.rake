# rake database:clear --trace

namespace :database do
  task :clear => :environment do

      puts "===== Cleaning Users ====="
      User.destroy_all
      execute "truncate table users restart identity"
  end
end