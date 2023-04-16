class LocationDecorator < ApplicationDecorator
  delegate_all

  def coordinates
    [x, y, z].join(", ")
  end

  def dimension_name
    dimension.titleize
  end

  def dimension_options
    h.options_for_select(Location.dimensions.keys.map { |k| [k.titleize, k] })
  end
end
