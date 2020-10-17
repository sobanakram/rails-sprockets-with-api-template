# frozen_string_literal: true

module ActiveStorage
  class AttachmentSerializer < ApplicationSerializer
    attributes :id, :url, :filename, :content_type, :metadata, :created_at

    def url
      Rails.application.routes.url_helpers.rails_blob_url @object
    end
  end
end
