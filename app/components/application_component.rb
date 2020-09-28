class ApplicationComponent < ViewComponent::Base
  include MinecraftServerCompendium::Colors
  include MinecraftServerCompendium::FetchOrFallback
end
