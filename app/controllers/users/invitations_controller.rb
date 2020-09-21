# frozen_string_literal: true

module Users
  class InvitationsController < Devise::InvitationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

  # GET /resource/invitation/new
  # def new
  #   super
  # end

  # POST /resource/invitation
  # def create
  #   super
  # end

  # GET /resource/invitation/accept?invitation_token=abcdef
  # def edit
  #   super
  # end

  # PUT /resource/invitation
  # def update
  #   super
  # end

  # GET /resource/invitation/remove?invitation_token=abcdef
  # def destroy
  #   super
  # end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[name username])
    end
  end
end
