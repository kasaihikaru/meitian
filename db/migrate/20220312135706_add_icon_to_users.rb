class AddIconToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :icon, :integer, default: 0
  end
end
