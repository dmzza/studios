desc "This task is called by the Heroku scheduler add-on"
task :pull_listings => :environment do
  session = ActionDispatch::Integration::Session.new(Rails.application)
  puts "Pulling listings..."
  session.get "/listings/pull"
  puts "done."
end
