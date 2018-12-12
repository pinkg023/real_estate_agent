class ContactMailer < ApplicationMailer
    def say_hello_to(email)
      @email = email
      admin_email = "pinkg023@gmail.com"
      mail to: @email, subject:"你好!!"
      mail to: admin_email, subject:"你好!!"
    end
end
