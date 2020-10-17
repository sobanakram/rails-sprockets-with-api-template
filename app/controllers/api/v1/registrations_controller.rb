# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception
      include Api::Concerns::ActAsApiRequest
      before_action :authenticate_user!, only: :update

      def_param_group(:user) do
        property :id, Integer
        property :active?, [true, false]
        param :name, String, required: true
        param :app_platform, String, desc: "Possible values: #{User.app_platforms.keys}", required: true
        param :app_version, String, required: true
        param :device_token, String
      end

      api :PUT, 'users.json', 'Reader Update'
      error 422, 'Unprocessable Entity'
      param_group :user
      returns :user, code: 201

      def update
        super
      rescue ArgumentError => e
        render_error(433, e.message)
      end

      private

      def account_update_params
        params.permit(:name, :device_token, :app_platform, :app_version)
      end

      def render_update_success
        render json: @resource
      end

      def render_create_error
        render json: {
          error: resource_errors[:full_messages].join(', ')
        }, status: :unprocessable_entity
      end

      def render_update_error
        render_create_error
      end
    end
  end
end
