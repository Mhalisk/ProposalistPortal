class AddLastNameToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :last_name, :string
  end
end
