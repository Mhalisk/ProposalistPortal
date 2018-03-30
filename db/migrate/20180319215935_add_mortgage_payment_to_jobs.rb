class AddMortgagePaymentToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :mortgage_payment, :bigint
  end
end
