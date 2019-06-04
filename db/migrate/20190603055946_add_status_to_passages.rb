class AddStatusToPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :passages, :status, :integer, limit: 1, default: 0
    add_column :papers, :status, :integer, limit: 1, default: 0
    add_column :rings, :status, :integer, limit: 1, default: 0
  end
end
