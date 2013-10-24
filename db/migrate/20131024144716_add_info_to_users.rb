class AddInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about_me, :text
    add_column :users, :experience, :text
    add_column :users, :education, :text
  end
end
