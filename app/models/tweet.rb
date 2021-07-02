class Tweet < ApplicationRecord
  belongs_to :user
  validates :text, presence: true, unless: :was_attached?
  has_one_attached :image, dependent: :destroy

  def was_attached?
    self.image.attached?
  end

  def self.search(search)
    if search !=""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
