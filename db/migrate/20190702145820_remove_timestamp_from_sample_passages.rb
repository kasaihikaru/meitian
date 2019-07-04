class RemoveTimestampFromSamplePassages < ActiveRecord::Migration[5.2]
  def change
    remove_column :sample_passages, :created_at, :datetime
    remove_column :sample_passages, :updated_at, :datetime
    remove_column :sample_p_words, :created_at, :datetime
    remove_column :sample_p_words, :updated_at, :datetime
    remove_column :sample_papers, :created_at, :datetime
    remove_column :sample_papers, :updated_at, :datetime
    remove_column :sample_sentences, :created_at, :datetime
    remove_column :sample_sentences, :updated_at, :datetime
    remove_column :sample_s_words, :created_at, :datetime
    remove_column :sample_s_words, :updated_at, :datetime
    remove_column :sample_rings, :created_at, :datetime
    remove_column :sample_rings, :updated_at, :datetime
    remove_column :sample_r_words, :created_at, :datetime
    remove_column :sample_r_words, :updated_at, :datetime
  end
end
