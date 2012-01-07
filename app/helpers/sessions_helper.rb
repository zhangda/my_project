module SessionsHelper
  def sign_in(user)
    cookies[:current_user] ={
      :value => user.id,
      :expires => 1.hour.from_now
    }
    self.current_user = user
  end

  def sign_out
    cookies.delete(:current_user)
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end
 
  def current_user
     @current_user ||=cookies[:current_user]
  end
   
  def current_user=(user)
     @current_user = user
  end

  def redirect_back_or(default)

    redirect_to(session[:return_to] || default)
    clear_return_to
  end


  private
 
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end
