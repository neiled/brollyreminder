desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
 puts "Sending user reminders..."
 User.check_weather_and_email_users
 puts "done."
end

