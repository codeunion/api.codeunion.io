Rails.application.routes.draw do
  namespace :v1, defaults: { format: "json" } do
    get "/search" => "resources#search"
  end
end
