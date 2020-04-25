class UpdateReadingsFromAllEarthWeatherStationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    WeatherEarthly.new.collect_and_save_all_latest_reports
  end
end
