module Servers
  class ListItemComponent < ApplicationComponent
    with_collection_parameter :server

    def initialize(server:)
      @server = server.decorate
    end
  end
end
