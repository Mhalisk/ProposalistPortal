class AddPhoneNumberToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :phone_number, :bigint
  end
end
