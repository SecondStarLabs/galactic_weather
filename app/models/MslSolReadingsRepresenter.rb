class MslSolReadingsRepresenter < Representable::Decorator
  include Representable::JSON

  collection :sols,
    decorator: SolRepresenter
end
