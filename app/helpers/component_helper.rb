module ComponentHelper
  def component(name, *args, **opts, &block)
    render component_class_for(name).new(*args, **opts), &block
  end

  def component_with_collection(name, collection, *args, **opts, &block)
    render component_class_for(name).with_collection(collection, *args, **opts), &block
  end

private

  def component_class_for(name)
    class_name, *namespace = component_name_for(name).to_s.split('/').reverse
    [*namespace.reverse, class_name].map(&:camelize).join('::').constantize
  end

  def component_name_for(name)
    name = name.to_s.downcase
    name = "#{name}_component" unless name.end_with?('_component')
    name
  end
end
