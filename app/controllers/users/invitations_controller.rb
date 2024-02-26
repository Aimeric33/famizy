class Users::InvitationsController < ApplicationController
  def after_invite_path_for(resource)
    families_path
  end
end
