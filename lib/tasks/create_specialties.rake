# rake specialties:create --trace

namespace :specialties do
  task :create => :environment do

    puts "===== Creating Specialties ====="
    Specialty.destroy_all
    ActiveRecord::Base.connection.execute("truncate table specialties restart identity")

    SPECIALTIES.each do |specialty|
      Specialty.create(:name => specialty)
    end
  end
end