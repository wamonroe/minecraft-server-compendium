module Servers
  class DetailComponent < ApplicationComponent
    def initialize(server:, **options)
      @server = server.decorate
      parse_options(options)
    end
  end
end
