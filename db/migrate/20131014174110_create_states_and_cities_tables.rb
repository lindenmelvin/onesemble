class CreateStatesAndCitiesTables < ActiveRecord::Migration
  def up
    create_table :states do |t|
      t.string :name
      t.string :abbreviation
    end
    
    create_table :cities do |t|
      t.integer :state_id
      t.string :name
    end
    
    add_column :users, :state_id, :integer
    add_column :users, :city_id, :integer
  end

  def down
    drop_table :states
    drop_table :cities
    remove_column :users, :state_id
    remove_column :users, :city_id
  end
end
