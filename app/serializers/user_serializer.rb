# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :name, :uid, :email, :device_token, :app_platform, :app_version, :active?
end
