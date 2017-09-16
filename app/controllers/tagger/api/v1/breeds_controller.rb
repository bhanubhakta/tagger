module Tagger
  module Api
    module V1
      class BreedsController < ApplicationController
        # Public: provides all the entities.
        #
        # Examples
        #
        #   /tagger/api/v1/breeds
        #   # => {
            #   "id": 1,
            #   "name": "My entity",
            #   "created_at": "2017-09-14T06:19:16.242Z",
            #   "updated_at": "2017-09-14T06:19:16.242Z"
            # }
        #
        # Returns all the breed records.
        def index
          @entities = Tagger.tagged_klass.constantize.includes(:tags).all
          render json: @entities
        end

        # Public: Create a breed and associated tags.
        #
        # Examples
        #
        #   /tagger/api/v1/breeds
          # {
          #   "entity": {
          #       "id": 1,
          #       "name": "Norwegian Forest Cat",
          #       "created_at": "2017-09-14T22:28:26.166Z",
          #       "updated_at": "2017-09-14T22:28:26.166Z"
          #   },

          #   "tags": [
          #       {
          #         "id": 1,
          #         "name": "Knows Kung Fu",
          #         "created_at": "2017-09-14T22:28:26.255Z",
          #         "updated_at": "2017-09-14T22:28:26.255Z"
          #       },
          #       {
          #         "id": 2,
          #         "name": "Climbs Trees",
          #         "created_at": "2017-09-14T22:28:26.275Z",
          #         "updated_at": "2017-09-14T22:28:26.275Z"
          #       }
          #   ]
          # }
        #
        # the created breed or an error if cannot be created.
        def create
          begin
            entity = Tagger::EntityTag.create_entity_tags(params)
            render json: { "#{Tagger.tagged_resource}": entity, tags: entity.tags}, status: 201
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: Provides a particular entity.
        #
        # Examples
        #
        #   /tagger/api/v1/breeds/:breed_id
          # {
          #   "entity": {
          #   "id": 1,
          #   "name": "My entity",
          #   "created_at": "2017-09-14T06:19:16.242Z",
          #   "updated_at": "2017-09-14T06:19:16.242Z"
          # },
          #   "tags": []
          # }
        #
        # Returns the entity record or provides an error message.
        def show
          begin
            breed = Tagger.tagged_klass.constantize.find(params[:id])
            render json: { "#{Tagger.tagged_resource}": breed, tags: breed.tags }
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: Updates the entity.
        #
        # /tagger/api/v1/breeds/:breed_id
        #
        #
        # Updates the entity.
        def update
          begin
            entity = Tagger::EntityTag.create_entity_tags(params)
            render json: { "#{Tagger.tagged_resource}": entity, tags: entity.tags }, status: 201
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: Deletes the breed.
        # Examples
        #
        #   /tagger/api/v1/breeds/:breed_id
        #
        # Returns successful message or error message.
        def destroy
          begin
            breed = Tagger.tagged_klass.constantize.find(params[:id])
            breed.destroy
            render json: { message: "Deleted successfully" }
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: API to provide stats of the breed.
        # Examples
        #
        #   /tagger/api/v1/breeds/stats
        # => [
          # {
          #     "id": 1,
          #     "name": "My entity",
          #     "tag_count": 0,
          #     "tag_ids": []
          # },
          # {
          #     "id": 2,
          #     "name": "My entity",
          #     "tag_count": 0,
          #     "tag_ids": []
          # },
        # Returns stats of the breeds.
        def stats
          render json: Tagger.tagged_klass.constantize.summary
        end
      end
    end
  end
end
