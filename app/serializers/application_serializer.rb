# frozen_string_literal: true

class ApplicationSerializer < ActiveModel::Serializer
  def active?
    object.active?
  end
end
