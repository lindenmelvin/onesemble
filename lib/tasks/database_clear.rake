# rake database:clear --trace

namespace :database do
  task :clear => :environment do

    puts "===== Cleaning Users ====="
    User.destroy_all
    ActiveRecord::Base.connection.execute("truncate table users restart identity")

    puts "===== Cleaning Instruments ====="
    Instrument.destroy_all
    ActiveRecord::Base.connection.execute("truncate table instruments restart identity")

    puts "===== Cleaning Genres ====="
    Genre.destroy_all
    ActiveRecord::Base.connection.execute("truncate table genres restart identity")

    puts "===== Cleaning Specialties ====="
    Specialty.destroy_all
    ActiveRecord::Base.connection.execute("truncate table specialties restart identity")

    puts "===== Cleaning Message ====="
    Message.destroy_all
    ActiveRecord::Base.connection.execute("truncate table messages restart identity")

  end
end