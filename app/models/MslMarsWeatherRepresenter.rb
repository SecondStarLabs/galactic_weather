class MslMarsWeatherRepresenter < OpenStruct
  include Representable::JSON

  property :id
  property :terrestrial_date
  property :sol
  collection :sols, decorator: MslSolRepresenter, class: MslSol
  nested :attributes do
    property :title
  end


end

class AlbumRepresenter < Representable::Decorator
  include Representable::JSON

  collection :data, class: SongRepresenter


end