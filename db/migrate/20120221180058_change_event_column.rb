class ChangeEventColumn < ActiveRecord::Migration
  def up
    rename_column :events, :name, :title
    rename_column :events, :start_at, :start
    rename_column :events, :end_at, :end
    add_column :events, :url, :string
  end

  def down
  end
end
