class CreateHomes < ActiveRecord::Migration[6.1]
  def change
    create_table :homes do |t|

      t.string :name
      t.text :description
      t.integer :price
      t.boolean :is_active, null: false, default: true
      t.integer :genre_id

      t.timestamps
    end
  end
end
