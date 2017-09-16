# Mounting route
module ActionDispatch::Routing
  class Mapper
    def mount_tagger
      Rails.application.routes.append do
        mount Tagger::Engine => 'tagger'
      end
    end
  end
end