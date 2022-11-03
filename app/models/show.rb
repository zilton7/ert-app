class Show < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons

  def full_title
    return "#{title} (#{year})" if year
    title
  end
end
