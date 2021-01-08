class HomesController < ApplicationController
  def show
    @passages = Passage.active.not_sapmle.recent.includes(:user)
    @papers = Paper.active.not_sapmle.recent.includes(:user)
    @hsk_passages = SamplePassage.hsk.active.four
  end
end
