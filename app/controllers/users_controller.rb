class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
    @collections = @user.collections
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
end