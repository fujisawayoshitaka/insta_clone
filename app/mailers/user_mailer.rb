class UserMailer < ApplicationMailer
  def user_mail(user)
    @user = user

    mail to: "1317699@gmail.com", subject: "blog投稿の確認メール"
  end
end
