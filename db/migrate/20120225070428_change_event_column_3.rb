class ChangeEventColumn3 < ActiveRecord::Migration
  def up
    add_column :events, :content, :text
  end

  def down
    remove_column :events, :content
  end
end
