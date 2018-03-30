class AddFirstNameToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :first_name, :string
  end
end
