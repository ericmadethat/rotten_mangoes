class UserMailer < ApplicationMailer
	default from: 'notifications@rottenmangoes.com'
  def alert_email(user)
  	@user = user
  	mail(to: @user.email, subject: 'Your account has been deleted')
  end
end
