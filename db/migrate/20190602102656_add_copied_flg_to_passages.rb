class AddCopiedFlgToPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :passages, :original_id, :integer
    add_column :papers, :original_id, :integer
    add_column :rings, :original_id, :integer
    add_column :sentences, :sample, :boolean
    add_column :sentences, :original_id, :integer
  end
end
