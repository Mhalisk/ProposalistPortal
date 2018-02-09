class Location < ApplicationRecord
  validates_presence_of :location

  has_many :jobs
end
