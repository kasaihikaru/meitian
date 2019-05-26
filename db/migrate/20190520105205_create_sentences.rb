class CreateSentences < ActiveRecord::Migration[5.2]
  def change
    create_table :sentences do |t|
      t.references :paper, index: true, foreign_key: true
      t.text    :ja
      t.text    :ch
      t.text    :pin
      t.boolean :memorized_ja, default:false, null:false
      t.boolean :memorized_ch, default:false, null:false
      t.boolean :pin_fixed, default:false, null:false
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
