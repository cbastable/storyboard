desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Updating feed..."
  NewsFeed.update
  puts "done."
end

task :reboot_sphinx => :environment do
  flying-sphinx restart
  flying-sphinx rebuild
end

task :run_index => :environment do
  flying-sphinx index
end