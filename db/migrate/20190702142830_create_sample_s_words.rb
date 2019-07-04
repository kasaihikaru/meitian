class CreateSampleSWords < ActiveRecord::Migration[5.2]
  def change
    create_table :sample_s_words do |t|
      t.references :sentence, index: true, foreign_key: true
      t.text    :ja
      t.text    :ch
      t.text    :pin
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
