class Show < ApplicationRecord
  has_many :seasons
  has_many :episodes, through: :seasons
end
