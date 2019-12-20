class UserMailer < ApplicationMailer
  def user_mail(user)
    @user = user

    mail to: "1317699@gmail.com", subject: "お問い合わせの確認メール"
  end
end
