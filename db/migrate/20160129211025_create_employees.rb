class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
    	t.string :name
    	t.string :title
    	t.float :salary
    	t.float :travel_fees
    	t.string :organization
    	t.integer :year
      t.timestamps null: false
    end
  end
end
