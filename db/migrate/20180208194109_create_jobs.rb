class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :customer_name
      t.string :job_link

      t.timestamps
    end
  end
end
