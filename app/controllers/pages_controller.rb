class PagesController < ApplicationController

  def home
    Feed.update(Rss.all.collect { |x| x.name })
    Feed.cleanup
  end


end
