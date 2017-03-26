Rails.application.routes.draw do

  get  '/api/notes'           => 'notes#index'
  post '/api/notes'           => 'notes#create'
  get  '/api/notes/tag/:name' => 'notes#by_tag_name'

  get  '/api/users' => 'users#index'
  post '/api/users' => 'users#create'


end
