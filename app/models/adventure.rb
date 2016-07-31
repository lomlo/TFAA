class Adventure < ApplicationRecord

  has_many :chapters
  has_many :games

  validates :title, uniqueness: true, presence: true
  validates :synopsis, presence: true

end
