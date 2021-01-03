class SamplePassagesController < ApplicationController

#-----------------get-----------------------
  def show
    @passage = SamplePassage.find(id_params)
    @words = @passage.sample_p_words.active
  end

  def copy
    passage = SamplePassage.find(sample_passage_id_params)
    user_id = current_user.id

    # 長文作成
    new_passage = Passage.create(title: passage.title, ja:passage.ja, ch: passage.ch, user_id: user_id, modified_at: Time.now, sample: false, status: 10)

    # 付属単語作成
    words = passage.sample_p_words.active
    words.each do |w|
      PWord.create(ja: w[:ja], ch: w[:ch], pin: w[:pin], pin_fixed: 1, passage_id: new_passage.id)
    end
    @msg = "マイ教材として保存しました。"
  end

end