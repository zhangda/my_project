class PagesController < ApplicationController

  def home
  end

  def refresh
    Feed.update(Rss.all.collect { |x| x.name })
    Feed.cleanup
    redirect_to root_path
  end


end
