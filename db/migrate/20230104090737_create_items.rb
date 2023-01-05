class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.timestamps
      t.integer :genre_id
      t.string :name
      t.integer :price
      t.text :introduction
      t.boolean :is_active
    end
  end
end
