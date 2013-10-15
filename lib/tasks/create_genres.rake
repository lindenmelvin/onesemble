# rake genres:create --trace

namespace :genres do
  task :create => :environment do

    puts "===== Cleaning Genres ====="
    Genre.destroy_all
    ActiveRecord::Base.connection.execute("truncate table genres restart identity")

    GENRES.each do |genre|
      Genre.create(:name => genre)
    end
  end
end