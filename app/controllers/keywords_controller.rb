class KeywordsController < ApplicationController
   before_filter :authenticate

   def index
     @keywords = current_user.keywords.paginate(:page => params[:page]) 
     @keyword = current_user.keywords.build
   end

   def create
      @keyword = current_user.keywords.build(params[:keyword])
      if @keyword.save
        flash[:success] = "keyword created!"
        redirect_to keywords_path
      else
        @keywords = current_user.keywords.paginate(:page => params[:page])
        render 'index'
      end
   end


end
