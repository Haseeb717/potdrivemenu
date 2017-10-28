class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :summary
      t.datetime :creation_time
      t.string :image_url
      t.string :link
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
