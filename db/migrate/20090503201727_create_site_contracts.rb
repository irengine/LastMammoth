class CreateSiteContracts < ActiveRecord::Migration
  def self.up
    create_table :site_contracts do |t|
      t.integer :site_id
      t.date :contract_begin_date
      t.date :contract_end_date
      t.integer :quantity
      t.integer :contract_status
      
      t.timestamps
    end
  end

  def self.down
    drop_table :site_contracts
  end
end
