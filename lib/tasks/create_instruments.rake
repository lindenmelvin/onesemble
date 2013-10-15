# rake instruments:create --trace

namespace :instruments do
  task :create => :environment do

    puts "===== Creating Instruments ====="
    Instrument.destroy_all
    ActiveRecord::Base.connection.execute("truncate table instruments restart identity")

    INSTRUMENTS.each do |instrument|
      Instrument.create(:name => instrument)
    end
  end
end