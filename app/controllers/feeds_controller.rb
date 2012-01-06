class FeedsController < ApplicationController
  def index
    Feed.update("http://rss.cnn.com/rss/edition.rss")
    @entries = Feed.all(:limit => 10, :order => "published_at desc")
  end

end
