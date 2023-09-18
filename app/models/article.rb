class Article < ApplicationRecord
    # Associations
    belongs_to :user
    has_many :reactions, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_one_attached :image

    # Validations
    validates :title, presence: true
    validates :description, presence: true

    Kinds = %w[like dislike not_interested neutral].freeze
    KindsSpanish = {"like" => "Me gusta", "dislike" => "No me gusta", "not_interested" => "No me interesa", "neutral" => "Neutral"}.freeze
    ReactionsIcons = {
        "like" => "fas fa-thumbs-up",
        "dislike" => "fas fa-thumbs-down",
        "not_interested" => "fas fa-meh",
        "neutral" => "fas fa-circle"
      }.freeze
end
