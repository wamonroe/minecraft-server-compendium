module Locations
  class ListItemComponent < ApplicationComponent
    with_collection_parameter :location

    def initialize(location:, **options)
      @location = location.decorate
      parse_options(options)
    end
  end
end
