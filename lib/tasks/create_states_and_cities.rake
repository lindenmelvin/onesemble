# rake states_and_cities:create --trace

namespace :states_and_cities do
  task :create => :environment do

    puts "===== Creating Cities and States ====="
    State.destroy_all
    ActiveRecord::Base.connection.execute("truncate table states restart identity")
    City.destroy_all
    ActiveRecord::Base.connection.execute("truncate table cities restart identity")

    STATES.each do |state|
      new_state = State.create(:name => state['name'], :abbreviation => state['abbreviation'])
      state['cities'].each do |city|
        puts city
        City.create(:name => city, :state_id => new_state.id)
      end
    end
  end
end