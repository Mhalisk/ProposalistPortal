class AddStateToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :state, :string
  end
end
