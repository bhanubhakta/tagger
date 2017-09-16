Tagger::Engine.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tags do
        collection do
          get 'stats'
        end
      end

      resources :breeds do
        collection do
          get 'stats'
        end
      end
      
      post '/breeds/:id/tags' => 'tags#replace_tag'
      get '/breeds/:id/tags' => 'breeds#tags'
      
      if Tagger.tagged_resource.present?
        get "#{Tagger.tagged_resource}/" => "breeds#index"
        get "#{Tagger.tagged_resource}/stats" => "breeds#stats"
        get "#{Tagger.tagged_resource}/:id" => "breeds#show"
        post "#{Tagger.tagged_resource}/" => "breeds#create"
        match "#{Tagger.tagged_resource}/:id" => "breeds#update",
          via: [:put, :patch]
        delete "#{Tagger.tagged_resource}/:id" => "breeds#destroy"
      end
    end
  end
end
