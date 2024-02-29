class Users::InvitationsController < Devise::InvitationsController
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, email: self.resource.email
      end
      if self.method(:after_invite_path_for).arity == 1
        respond_with resource, location: after_invite_path_for(current_inviter)
      else
        respond_with resource, location: after_invite_path_for(current_inviter, resource)
      end
    else
      render 'families/invite', layout: 'dashboard', status: :unprocessable_entity
    end
  end

  def after_invite_path_for(resource)
    family_invite_path(params[:locale])
  end
end
