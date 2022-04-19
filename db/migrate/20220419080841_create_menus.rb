class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :name
      t.float :price
      t.text :description
      t.integer :is_deleted

      t.timestamps
    end
  end
end
