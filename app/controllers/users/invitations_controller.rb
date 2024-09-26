class Users::InvitationsController < Devise::InvitationsController
  def create
    super do |resource|
      if resource.errors.empty?
        product=Product.find(params[:product_id])
        UserMailer.welcome(resource, resource.invitation_token, product).deliver_now
        redirect_to orders_path
      else
        redirect_back fallback_location: orders_path
      end
    end
  end
end
