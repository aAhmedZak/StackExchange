class User < ApplicationRecord
  has_secure_password

  include V1::UserPresenter

  validates :username, presence: :true
end
