class AddCityAndStateIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :state_id, :integer
    add_column :posts, :city_id, :integer
    
    add_index :posts, :state_id
    add_index :posts, :city_id
  end
end
