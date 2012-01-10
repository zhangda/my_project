class FeedsController < ApplicationController
  before_filter :authenticate

  def index
    query_string =  current_user.keywords.collect { |x| 
     "upper(content) like '% "+x.value+" %'" }.join(" or ")
    @entries = Feed.paginate(:page => params[:page], :per_page => 5, 
                             :conditions => query_string
                            ).order("published_at desc")
  end

end
