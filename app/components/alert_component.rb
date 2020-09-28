module Shared
  class AlertComponent < ApplicationComponent
    def initialize(type:, data:)
      @type = type
      @data = prepare_data(data)
      @icon_path = icon_path
      @icon_color = icon_color
      @title_color = title_color

      @data[:timeout] ||= 3
    end

  private

    def icon_path
      case @type
      when 'success'
        'icons/check-circle-solid.svg'
      when 'error'
        'icons/x-circle-solid.svg'
      when 'alert'
        'icons/exclamation-circle-solid.svg'
      else
        'icons/information-circle-solid.svg'
      end
    end

    def icon_color
      case @type
      when 'success'
        'text-green-400'
      when 'error'
        'text-red-400'
      when 'alert'
        'text-yellow-400'
      else
        'text-gray-400'
      end
    end

    def prepare_data(data)
      return data.symbolize_keys if data.is_a?(Hash)

      { title: data }
    end

    def title_color
      case @type
      when 'success'
        'text-green-800'
      when 'error'
        'text-red-800'
      when 'alert'
        'text-yellow-800'
      else
        'text-gray-800'
      end
    end
  end
end
