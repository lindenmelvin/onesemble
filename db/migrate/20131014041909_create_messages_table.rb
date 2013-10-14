class CreateMessagesTable < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.text :body
      t.string :ancestry
      t.timestamps
    end
     add_index :messages, :ancestry
  end

  def down
    remove_index :messages, :ancestry
    drop_table :messages
  end
end
