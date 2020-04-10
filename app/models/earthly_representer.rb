class EarthlyRepresenter < Representable::Decorator
  include Representable::JSON

  # collection
# "coord"=>{"lon"=>76.26, "lat"=>9.94}
  property :id
  property :coord, class: Coord do
    property :lat
    property :lon
  end

  collection :weather, class: Weather do
    property :id
    property :main
    property :description
    property :icon
  end
  
  property :base
  
  property :main, class: Atmospheric do
    property :temp
    property :feels_like
    property :temp_min
    property :temp_max
    property :pressure
    property :humidity
  end
  
  property :visibility

  property :wind, class: Wind do
    property :speed
    property :deg
  end

  property :clouds, class: CloudCoverage do
    property :all
  end

  property :dt
  property :sys, class: Location do
    property :type
    property :id
    property :country
    property :sunrise
    property :sunset
  end

  property :timezone
  property :id
  property :name
  property :cod

end

