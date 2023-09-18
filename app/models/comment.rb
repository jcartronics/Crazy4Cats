class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :article
  has_many :reactions, dependent: :destroy

  # Validations
end
