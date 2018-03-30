class AddAnnualIncomeToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :annual_income, :bigint
  end
end
