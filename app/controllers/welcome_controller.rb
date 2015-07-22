class WelcomeController < ApplicationController
  before_action :set_newest_collections

  def index
  end

  private
    def set_newest_collections
      @newest_collections = Collection.order("created_at DESC").limit(10)
    end
end
