class Movie < ApplicationRecord
  has_many :bookmarks
  # has_and_belongs_to_many :bookmarks
  validates :overview, presence: true
  validates :title, uniqueness: true, presence: true
end
