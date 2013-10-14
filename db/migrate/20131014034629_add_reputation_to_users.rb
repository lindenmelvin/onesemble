class AddReputationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reputation, :decimal
  end
end
