class Job < ApplicationRecord
  validates_presence_of :customer_name, :job_link

  belongs_to :company

  def self.encor
    where(company_id: 1)
  end

  def self.powerhome
    where(company_id: 2)
  end
end
