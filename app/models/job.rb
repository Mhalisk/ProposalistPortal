class Job < ApplicationRecord
  validates_presence_of :customer_name, :job_link

  belongs_to :company
end
