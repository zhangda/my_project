class Mymailer < ActionMailer::Base
  default :from => "zhangda34ko@gmail.com"

  def news_feed(user, entries)
    @entries = entries
    mail(:to => user.email, :subject =>"News feed")
  end

end
