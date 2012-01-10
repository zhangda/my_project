class FeedsController < ApplicationController
  before_filter :authenticate

  def index
    query_string =  current_user.keywords.collect { |x| 
     "upper(content) like '% "+x.value.upcase+" %'" }.join(" or ")
    @entries = Feed.paginate(:page => params[:page], :per_page => 5, 
                             :conditions => query_string
                            ).order("published_at desc")
  end

  def send_mail
    query_string =  current_user.keywords.collect { |x|
     "upper(content) like '% "+x.value.upcase+" %'" }.join(" or ")
    @entries = Feed.where(query_string).order("published_at desc")
    Mymailer.news_feed(current_user, @entries).deliver
    redirect_to feeds_path
  end
 

end
