class CreatePapers < ActiveRecord::Migration[5.2]
  def change
    create_table :papers do |t|
      t.references :user, index: true, foreign_key: true
      t.string  :name, null:false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
