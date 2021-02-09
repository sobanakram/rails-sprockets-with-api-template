class User < ApplicationRecord
  # Constants

  # Attributes

  # Extensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable, :lockable, :trackable
  include DeviseTokenAuth::Concerns::User
  include Base64AttachmentSupport
  include Statusable

  enum app_platform: {android: 0, ios: 1}

  # Relationships

  # Validations

  # Scopes
  scope :logged_in, -> { where.not(tokens: {}) }

  # Callbacks

  # Class Methods

  # Instance Methods

  def logged_in?
    tokens != {}
  end

  def email_required?
    true
  end

  def active_for_authentication?
    true
  end

  private

  def uses_email?
    provider == "email" || email.present?
  end

  def init_uid
    self.uid = email if uid.blank? && provider == "email"
  end
end
