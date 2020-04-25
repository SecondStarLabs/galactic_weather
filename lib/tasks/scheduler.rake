desc "This cities task is called by the Heroku scheduler add-on"
task :update_earth => :environment do
  puts "Updating readings for Earth cities..."
  UpdateReadingsFromAllEarthWeatherStationsJob.perform_later
  puts "done."
end

task :update_mars_from_station_one => :environment do
    puts "Updating readings for Mars station one..."
    UpdateReadingsFromMarsWeatherStationJob.perform_later(1)
end

task :update_mars_from_station_two => :environment do
  puts "Updating readings for  Mars station two..."
  UpdateReadingsFromMarsWeatherStationJob.perform_later(2)
  puts "done."
end