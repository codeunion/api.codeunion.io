require "rails_helper"

describe "Searching for Resources" do
  it "Stores search results for resources returned by the query" do
    findable_resources = 10.times.map { FactoryGirl.create(:findable_resource) }
    unfindable_resources = 10.times.map { FactoryGirl.create(:unfindable_resource) }

    search_query = "information"

    get "/v1/search", { query: search_query }

    findable_resources.each do |resource|
      expect(resource).to have_search_results_for(search_query)
    end

    unfindable_resources.each do |resource|
      expect(resource).not_to have_search_results_for(search_query)
    end
  end
end
