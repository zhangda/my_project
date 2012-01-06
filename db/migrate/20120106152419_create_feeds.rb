class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :title
      t.string :url
      t.text :summary
      t.text :content
      t.datetime :published_at
      t.string :guid

      t.timestamps
    end
  end
end
