class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_referrer
  before_action :set_referrer_path

  private

  def set_referrer
    @referrer = params.permit(:referrer)[:referrer]
  end

  def set_referrer_path
    @referrer_path = helpers.referrer_from(@referrer)
  end
end
