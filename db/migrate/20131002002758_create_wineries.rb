class CreateWineries < ActiveRecord::Migration
  def up
    create_table :wineries do |t|
      t.string :name
      t.string :address
      t.string :url
      t.timestamps
    end
  end

  def down
    drop_table :wineries
  end
end
