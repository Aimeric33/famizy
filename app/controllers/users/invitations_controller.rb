class Users::InvitationsController < ApplicationController
  def after_invite_path_for(resource)
    new_user_invitation_path(params[:locale])
  end
end
