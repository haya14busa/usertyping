class WelcomeController < ApplicationController
  before_action :set_newest_collections

  def index
    @n_of_collections = Collection.count
    @n_of_users = User.count
  end

  private
    def set_newest_collections
      @newest_collections = Collection.order("created_at DESC").limit(10)
    end
end
