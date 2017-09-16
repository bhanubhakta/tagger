module Tagger
  module Api
    module V1
      class TagsController < ApplicationController
        # Public: provides all the tags.
        #
        # Examples
        #
        #   /tagger/api/v1/tags
        # 
        # Returns all the tags.
        def index
          @tags = Tagger::Tag.all
          render json: @tags
        end

        # Public: Provides a particular tag.
        #
        # Examples
        #
        #   /tagger/api/v1/tags/:tag_id
        #
        # Returns the tag record or provides an error message.    
        def show
          begin
            @tag = Tagger::Tag.find(params[:id])
            render json: @tag
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: Updates the tag.
        #
        # /tagger/api/v1/tags/:tag_id
        #
        #
        # Updates the tag.
        def update
          begin
            tag = Tagger::Tag.find(params[:id])
            tag.update({ name: params[:name] })
            render json: tag, status: 201
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: Deletes the tags.
        # Examples
        #
        #   /tagger/api/v1/tags/:tag_id
        #
        # Returns successful message or error message.
        def destroy
          begin
            tag = Tagger::Tag.find(params[:id])
            tag.send(Tagger.association).delete_all
            tag.destroy
            render json: { message: "Deleted successfully" }
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: API to replace tag.
        # Examples
        #
        #   /tagger/api/v1/breeds/:breed_id/tags
        #
        # Returns replaced tags or an error message.
        def replace_tag
          begin
            entity = Tagger::EntityTag.create_entity_tags(params)
            render json: { entity: entity, tags: entity.tags }, status: 201
          rescue Exception => e
            render json: { error: "Unprocessable entity" }, status: 422
          end
        end

        # Public: API to provide stats of the tag.
        # Examples
        #
        #   /tagger/api/v1/tags/stats
        # 
        # Returns stats of the tags.
        def stats
          render json: Tagger::Tag.summary
        end
      end
    end
  end
end