class AddSampleFlgNewToPassages < ActiveRecord::Migration[5.2]
  def change
    add_column :passages, :sample, :boolean, default: false, null: false
    add_column :papers, :sample, :boolean, default: false, null: false
    add_column :rings, :sample, :boolean, default: false, null: false
  end
end
