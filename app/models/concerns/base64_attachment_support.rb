# frozen_string_literal: true

module Base64AttachmentSupport
  extend ActiveSupport::Concern

  included do
    include ActiveStorageSupport::SupportForBase64
  end

  def attach_base64_image(attribute_name, base64_data)
    image_hash = { data: "data:image/png;base64,#{base64_data}" }
    send(attribute_name).attach(image_hash)
  end

  def active_storage_url(attachment)
    if attachment.attached?
      Rails.application.routes.url_helpers.rails_blob_url(attachment)
    end
  end
end
