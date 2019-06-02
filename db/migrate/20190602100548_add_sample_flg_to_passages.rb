class AddSampleFlgToPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :passages, :sample, :boolean
    add_column :papers, :sample, :boolean
    add_column :rings, :sample, :boolean
  end
end