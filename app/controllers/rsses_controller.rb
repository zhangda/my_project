class RssesController < ApplicationController
   before_filter :authenticate

   def index
     @rsses = Rss.paginate(:page => params[:page])
     @rss = Rss.new
   end

   def create
      @rss = Rss.new(params[:rss])
      if @rss.save
        flash[:success] = "rss created!"
        redirect_to rsses_path
      else
        @rsses = Rss.paginate(:page => params[:page])
        render 'index'
      end
   end

   def destroy
     Rss.find(params[:id]).destroy
     flash[:success] = "rss deleted!"
     redirect_to rsses_path
   end




end
