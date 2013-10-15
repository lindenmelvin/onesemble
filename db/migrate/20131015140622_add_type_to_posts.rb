class AddTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :type, :string
    add_column :posts, :rate, :decimal
    add_column :posts, :hourly, :boolean
  end
end
