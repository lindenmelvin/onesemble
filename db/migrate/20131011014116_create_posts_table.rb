class CreatePostsTable < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :subject
      t.string :body
      t.integer :user_id
      t.timestamps
    end
  end

  def down
    drop_table :posts
  end
end
