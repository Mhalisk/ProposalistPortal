class AddSsnToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :ssn, :bigint
  end
end
