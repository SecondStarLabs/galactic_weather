class SolRepresenter < Representable::Decorator
  include Representable::JSON

  property :id
  property :terrestrial_date
  property :sol
  property :ls
  property :season
  property :min_temp
  property :max_temp
  property :pressure
  property :pressure_string
  property :abs_humidity
  property :wind_speed
  property :wind_direction
  property :atmo_opacity
  property :sunrise
  property :sunset
  property :local_uv_irradiance_index
  property :min_gts_temp
  property :max_gts_temp

end
