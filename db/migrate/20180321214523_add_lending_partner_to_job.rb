class AddLendingPartnerToJob < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :lending_partner, :string
  end
end
