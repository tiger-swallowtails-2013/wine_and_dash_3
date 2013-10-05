class AddLatLongWinery < ActiveRecord::Migration
  def up
    add_column :wineries, :lat, :float
    add_column :wineries, :long, :float
  end

  def down
    remove_column :wineries, :lat
    remove_column :wineries, :long
  end
end

