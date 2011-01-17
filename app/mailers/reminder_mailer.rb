class ReminderMailer < ActionMailer::Base
  default :from => "noreply@brollyreminder.com"

  def send_reminder(user, weather_response)
    @cancel_url = cancel_url(:guid => user.confirm_guid, :id => user.id)
    @page_url = weather_response.page_url
    mail(:to => user.email_address, \
         :subject => "Take your brolly - it's going to rain today.")
  end # send_reminder(user)

  def send_confirmation(user)
    @confirm_url = confirm_url(:guid => user.confirm_guid, :id => user.id)
    mail(:to => user.email_address, \
         :subject => "BrollyReminder - Confirm your email address.")
  end
  
end
