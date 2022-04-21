class AddDefaultValueStatusOrder < ActiveRecord::Migration[7.0]
  def change
    change_column :orders, :status, :string, :default => "UNPAID"
  end
end
