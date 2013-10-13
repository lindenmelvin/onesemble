class AddInstrumentIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :instrument_id, :integer
    add_column :posts, :genre_id, :integer
  end
end
