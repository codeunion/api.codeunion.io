module V1
  class ResourcesController < ApplicationController
    def search
      render json: Resource.search(search_params)
    end

  private

    def search_params
      params.slice(:category, :query)
    end
  end
end
