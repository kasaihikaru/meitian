class CreateSamplePassages < ActiveRecord::Migration[5.2]
  def change
    create_table :sample_passages do |t|
      t.integer  :level, limit: 1, default: 0
      t.string  :title, null:false
      t.text    :ja
      t.text    :ch
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
