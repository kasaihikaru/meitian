class RemoveSampleFromPassages < ActiveRecord::Migration[5.2]
  def change
    remove_column :passages, :sample, :boolean
    remove_column :papers, :sample, :boolean
    remove_column :rings, :sample, :boolean
    remove_column :sentences, :sample, :boolean
  end
end
