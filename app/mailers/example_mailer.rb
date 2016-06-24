class ExampleMailer < ApplicationMailer

default from: "from@example.com"

  def sample_email(user)
    if @user = user 
    mail(to: @user.email, subject: 'Notice of account removal')
  	end
  end
end



#create new column in users table called is_deleted? 
#true or false 
# 
