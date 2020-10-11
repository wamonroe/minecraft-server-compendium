class ApplicationComponent < ViewComponent::Base
  def merge_classes(*class_strings)
    results = []
    class_strings.each { |s| results.concat(s.to_s.downcase.split) }
    results.compact.uniq.join(' ')
  end

private

  def parse_options(options={})
    @additional_classes = options[:class]
    @options = options.except(:class)
  end
end
