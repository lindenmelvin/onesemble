class CreateInstrumentsAndSpecialtiesTables < ActiveRecord::Migration
  def up
    create_table :instruments do |t|
      t.string :name
    end
    
    create_table :specialties do |t|
      t.string :name
    end
    
    create_table :genres do |t|
      t.string :name
    end
  end

  def down
    drop_table :instruments
    drop_table :specialties
    drop_table :genres
  end
end
