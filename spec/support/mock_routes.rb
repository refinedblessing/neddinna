MockApp.routes.draw do
  get "/index", to: "mock#index"
  post "/create", to: "mock#create"
  put "/update", to: "mock#update"
  delete "/destroy", to: "mock#destroy"
end
