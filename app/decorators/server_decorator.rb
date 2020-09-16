class ServerDecorator < ApplicationDecorator
  delegate_all

  decorates_association :locations

  def hostname_and_port
    default_port? ? hostname : "#{hostname}:#{port}"
  end
end
