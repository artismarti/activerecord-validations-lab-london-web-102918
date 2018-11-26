class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :content, length: {minimum:250}
  validates :summary, length: {maximum:250}
  validates :category, inclusion: {in: %w(Fiction Non-Fiction), message: "%{value} is not a valid category"}
  validate :clickbait

  CLICKBAIT_TITLES = [
    /Won't Believe/i,
    /Secret/i,
    /Top [number]/i,
    /Guess/i
  ]

  def clickbait
    if CLICKBAIT_TITLES.none? {|ct| ct.match title}
      errors.add(:title, "must be clickbait!")
    end
  end
end
