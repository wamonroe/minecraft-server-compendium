module ApplicationHelper
  def referrer_for(url_or_path)
    return if url_or_path.blank?

    Base64.urlsafe_encode64(url_or_path, padding: false)
  end

  def referrer_from(base64_string)
    return if base64_string.blank?

    Base64.urlsafe_decode64(base64_string)
  end
end
