module V1
  class ResourcesController < ApplicationController
    def search
      category = params[:category]
      query    = params[:query]

      unless query
        render json: { error: "Must provide a URL parameter with key 'query'." },
               status: :unprocessable_entity
        return
      end

      if category && !Resource.valid_category?(category)
        render json: { error: "Category '#{category}' does not exist." },
               status: :unprocessable_entity
        return
      end

      if category
        resources = Resource.in_category(category).search_in_readme(query)
      else
        resources = Resource.search_in_readme(query)
      end

      render json: resources
    end
  end
end
