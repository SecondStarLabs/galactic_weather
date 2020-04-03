class SolRepresenter < Representable::Decorator
  include Representable::JSON

  # collection

  property :First_UTC
  property :Last_UTC
  property :Season
  property :sol
end
