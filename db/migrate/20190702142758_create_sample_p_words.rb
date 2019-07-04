class CreateSamplePWords < ActiveRecord::Migration[5.2]
  def change
    create_table :sample_p_words do |t|
      t.references :passage, index: true, foreign_key: true
      t.text    :ja
      t.text    :ch
      t.text    :pin
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
