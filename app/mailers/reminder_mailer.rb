class ReminderMailer < ActionMailer::Base
  default :from => "noreply@brollyreminder.com"

  def send_reminder(user)
    @cancel_url = "http://brollyreminder.com/cancel/#{user.id}/#{user.email_address}/"
    mail(:to => user.email_address, \
         :subject => "Take your brolly - it's going to rain today.")
  end # send_reminder(user)
  
end
