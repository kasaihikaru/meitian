class CreatePassages < ActiveRecord::Migration[5.2]
  def change
    create_table :passages do |t|
      t.references :user, index: true, foreign_key: true
      t.string  :title, null:false
      t.text    :ja
      t.text    :ch
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
