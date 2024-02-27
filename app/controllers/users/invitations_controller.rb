class Users::InvitationsController < Devise::InvitationsController
  def after_invite_path_for(resource)
    family_invite_path(params[:locale])
  end
end
