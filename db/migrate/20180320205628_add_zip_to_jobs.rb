class AddZipToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :zip, :bigint
  end
end
