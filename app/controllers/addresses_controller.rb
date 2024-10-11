class AddressesController < ApplicationController
  def edit
    @address =current_user.addresses.find(params[:id])
  end

  def update_address
    @address =current_user.addresses.find(params[:id])
    if @address.update(address_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:barangay, :zip_code, :street, :house_number)
  end
end
