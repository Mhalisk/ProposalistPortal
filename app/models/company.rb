class Company < ApplicationRecord
  validates_presence_of :company_name

  has_many :jobs
end
