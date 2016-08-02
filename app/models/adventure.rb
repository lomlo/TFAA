class Adventure < ApplicationRecord

  has_many :chapters
  has_many :choices, through: :chapters 

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates :title, uniqueness: true, presence: true
  validates :synopsis, presence: true
  validates :image, presence: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

end
