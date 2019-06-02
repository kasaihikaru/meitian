class AddSampleFlgToSentences < ActiveRecord::Migration[5.2]
  def change
    add_column :sentences, :sample, :boolean, default: false, null: false
  end
end
