# frozen_string_literal: true

module Statusable
  extend ActiveSupport::Concern

  included do
    enum status: { active: 0, inactive: 1, blocked: 2, on_hold: 3 }

    after_validation :activate
  end

  def status_text
    return status unless respond_to?(:status_texts)

    status_texts[status.to_sym]
  end

  private

  def activate
    self.status = :active if status.nil?
  end
end
