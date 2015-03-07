class Movie < ActiveRecord::Base
  has_many :reviews

  validates :title,
    presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_future

  mount_uploader :image, ImageUploader

  def self.search(title, director, runtime)
    if title || director || runtime
      min_runtime = 0
      max_runtime = 240
      case runtime
      when 2
        max_runtime = 90
      when 3
        min_runtime = 90
        max_runtime = 120
      when 4
        min_runtime = 120
      end
      @movies = Movie.where("title LIKE ? AND director LIKE ? AND runtime_in_minutes BETWEEN ? AND ?", "%#{title}%", "%#{director}%", min_runtime, max_runtime)
    end
  end

  def review_average
    reviews.sum(:rating_out_of_ten)/reviews.size if reviews.size != 0
  end

  protected
  def release_date_is_in_the_future
    if release_date.present?
      errors.add(:release_date, "should probably be in the future") if release_date < Date.today
    end
  end

end
