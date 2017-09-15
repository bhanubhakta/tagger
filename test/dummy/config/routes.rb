Rails.application.routes.draw do
  mount Tagger::Engine => "/tagger"
end
