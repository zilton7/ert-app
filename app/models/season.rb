class Season < ApplicationRecord
  belongs_to :show
  has_many :episodes, dependent: :destroy
end
