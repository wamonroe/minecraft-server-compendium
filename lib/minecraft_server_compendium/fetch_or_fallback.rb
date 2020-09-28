module MinecraftServerCompendium
  module FetchOrFallback
    extend ActiveSupport::Concern

    def fetch_or_fallback(allowed_values, given_value, fallback)
      if allowed_values.include?(given_value)
        given_value
      else
        raise ArgumentError, "not allowed value: '#{given_value}'" if Rails.development?

        fallback
      end
    end
  end
end
