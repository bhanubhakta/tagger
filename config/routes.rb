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
        get "#{Tagger.tagged_resource}/:id/tags" => 'breeds#tags'

        post "#{Tagger.tagged_resource}/" => "breeds#create"
        post "#{Tagger.tagged_resource}/:id/tags" => 'tags#replace_tag'

        match "#{Tagger.tagged_resource}/:id" => "breeds#update",
          via: [:put, :patch]
          
        delete "#{Tagger.tagged_resource}/:id" => "breeds#destroy"
      end
    end
  end
end
