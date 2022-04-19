class ChangeIsDeletedMenu < ActiveRecord::Migration[7.0]
  def change
    change_column :menus, :is_deleted, :integer, :default => 0
  end
end
