class AddStartAndEndTimeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :start_date, :timestamp
    add_column :posts, :end_date, :timestamp
    add_column :posts, :all_day, :boolean, default: false
  end
end
