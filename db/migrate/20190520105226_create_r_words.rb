class CreateRWords < ActiveRecord::Migration[5.2]
  def change
    create_table :r_words do |t|
      t.references :ring, index: true, foreign_key: true
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
