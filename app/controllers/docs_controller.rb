class DocsController < ApplicationController

  def term
  end

  def privacy
  end

  def hsk_index
    @hsk_passages = SamplePassage.hsk.active
  end

end
