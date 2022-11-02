class Show < ApplicationRecord
  has_many :seasons
  has_many :episodes, through: :seasons

  def self.search(q)
    self.where("title ilike ?", "%#{q}%")
  end
end
