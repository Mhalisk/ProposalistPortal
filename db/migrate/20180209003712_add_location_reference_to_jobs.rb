class AddLocationReferenceToJobs < ActiveRecord::Migration[5.1]
  def change
    add_reference :jobs, :location, foreign_key: true
  end
end
