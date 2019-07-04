class CreateSampleRings < ActiveRecord::Migration[5.2]
  def change
    create_table :sample_rings do |t|
      t.integer  :level, limit: 1, default: 0
      t.string  :name, null:false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
