class CreateRecommendations < ActiveRecord::Migration
  def up
    create_table :recommendations do |t|
      t.integer :user_id
      t.integer :recommender_id
      t.string :subject
      t.text :body
    end
    
    add_index :recommendations, :user_id
    add_index :recommendations, :recommender_id
  end

  def down
    drop_table :recommendations
  end
end
