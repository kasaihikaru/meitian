class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :level, :integer, limit: 1, default: 0
  end
end