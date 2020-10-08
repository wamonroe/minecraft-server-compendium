class ContainerComponent < ApplicationComponent
  SIZES = {
    sm: 'max-w-screen-sm',
    md: 'max-w-screen-md',
    lg: 'max-w-screen-lg',
    xl: 'max-w-screen-xl'
  }.with_indifferent_access.freeze

  def initialize(size: :md)
    @size = SIZES[size]
  end
end
