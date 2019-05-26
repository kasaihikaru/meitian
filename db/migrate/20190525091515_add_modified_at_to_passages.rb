class AddModifiedAtToPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :passages, :modified_at, :datetime
    add_column :papers, :modified_at, :datetime
    add_column :rings, :modified_at, :datetime
  end
end
