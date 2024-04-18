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
      render 'families/edit', layout: 'dashboard', status: :unprocessable_entity
    end
  end

  private

  def after_invite_path_for(resource)
    edit_family_path(params[:locale])
  end

  def after_accept_path_for(resource)
    families_path(params[:locale])
  end

  protected

  # invite_resource is called when creating invitation
  # should return an instance of resource class

  # this is devise_invitable's implementation
  # def invite_resource(&block)
  #   resource_class.invite!(invite_params, current_inviter, &block)
  # end

  def invite_resource(&block)
    @user = User.find_by(email: invite_params[:email])

    # @user is an instance or nil
    if @user && @user.email != current_user.email
      @user.families << Family.find(invite_params[:family_ids].to_i) unless @user.families.include?(Family.find(invite_params[:family_ids].to_i))
      # invite! instance method returns a Mail::Message instance
      @user.invite!(current_user)
      # return the user instance to match expected return type
      @user
    else
      # invite! class method returns invitable var, which is a User instance
      resource_class.invite!(invite_params, current_inviter, &block)
    end
  end
end
