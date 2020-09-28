module MinecraftServerCompendium
  module Colors
    extend ActiveSupport::Concern

    COLORS = %w[gray red orange yellow green teal blue indigo purple pink].freeze
    COLOR_SHADES = %w[100 200 300 400 500 600 700 800 900].freeze

    def self.build_colors(type)
      colors = COLORS.map do |color|
        COLOR_SHADES.map do |shade|
          "#{type}-#{color}-#{shade}"
        end
      end
      colors.concat(["#{type}-black", "#{type}-white"])
    end

    BORDER_COLORS = build_colors('border').freeze
    BG_COLORS = build_colors('bg').freeze
    TEXT_COLORS = build_colors('text').freeze
  end
end
