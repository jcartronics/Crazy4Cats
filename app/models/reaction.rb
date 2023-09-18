class Reaction < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  # Validations
end
