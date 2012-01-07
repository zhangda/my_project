module SessionsHelper
  def sign_in(user)
    cookies[:current_user] ={
      :value => user.id,
      :expires => 1.hour.from_now
    }
    current_user = user
  end

  def sign_out
    cookies.delete(:current_user)
    current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end
 
  def current_user
     if cookies[:current_user].nil?
       return @current_user
     else
       @current_user ||=User.find(cookies[:current_user].to_i)
     end
  end
   
  def current_user=(user)
     @current_user = user
  end
 
  def authenticate
    deny_access unless signed_in?
  end

  def deny_access
    store_location
    redirect_to signin_path, :notice => "Please sign in to access this page"
  end

 
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end
  
  def current_user?(user)
    user == current_user
  end
 

  private
 
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

end
