class CreateContractsRequestsAndRatingsTables < ActiveRecord::Migration
  def up
    create_table :contracts do |t|
      t.boolean :complete, default: false
      
      t.timestamps
    end
    
    create_table :contracts_users do |t|
      t.integer :user_id
      t.integer :contract_id
    end
    
    add_index :contracts_users, :user_id
    add_index :contracts_users, :contract_id
    
    create_table :requests do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.boolean :pending, defalut: true
      t.boolean :accepted
      
      t.timestamps
    end
    
    add_index :requests, :sender_id
    add_index :requests, :receiver_id
    
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :rater_id
      t.integer :contract_id
      t.integer :rating
      
      t.timestamps
    end
    
    add_index :ratings, :user_id
    add_index :ratings, :rater_id
    add_index :ratings, :contract_id
  end

  def down
  end
end
