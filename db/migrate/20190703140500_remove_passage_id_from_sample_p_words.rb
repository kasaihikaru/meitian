class RemovePassageIdFromSamplePWords < ActiveRecord::Migration[5.2]
  def change
    remove_column :sample_p_words, :passage_id, :integer
    remove_column :sample_r_words, :ring_id, :integer
    remove_column :sample_s_words, :sentence_id, :integer
    remove_column :sample_sentences, :paper_id, :integer

    add_reference :sample_p_words, :sample_passage, index: true, foreign_key: true
    add_reference :sample_r_words, :sample_ring, index: true, foreign_key: true
    add_reference :sample_s_words, :sample_sentence, index: true, foreign_key: true
    add_reference :sample_sentences, :sample_paper, index: true, foreign_key: true
  end
end