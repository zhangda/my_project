class ChangeEventColumn2 < ActiveRecord::Migration
  def up
    rename_column :events, :start, :starts_at
    rename_column :events, :end, :ends_at
  end

  def down
  end
end
