class UserMailer < ApplicationMailer
	def registration(user)
		@user = user

		mail(
			to: @user.email,
			subject: '【MeiTian】ご利用案内',
		)
	end
end