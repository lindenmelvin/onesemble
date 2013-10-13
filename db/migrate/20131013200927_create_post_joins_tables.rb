class CreatePostJoinsTables < ActiveRecord::Migration
  def up
    create_table :instruments_posts do |t|
      t.integer :instrument_id
      t.integer :post_id
    end
    
    create_table :genres_posts do |t|
      t.integer :genre_id
      t.integer :post_id
    end
    
    create_table :specialties_posts do |t|
      t.integer :specialty_id
      t.integer :post_id
    end
    
    remove_column :posts, :instrument_id
    remove_column :posts, :genre_id
  end

  def down
    drop_table :specialties_posts
    drop_table :genres_posts
    drop_table :instruments_posts
    add_column :posts, :instrument_id, :integer
    add_column :posts, :genre_id, :integer
  end
end
