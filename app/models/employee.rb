class Employee < ActiveRecord::Base
	# belongs_to :organization
	
	# enforce "primary key" = [name, org, year]
	# because names are unique within each org (not realistic but this is what we are given)
	validates :name, uniqueness: { scope: [:organization, :year] }
	validates :name, length: { maximum: 100 }
	validates :title, length: { maximum: 100 }
	validates :organization, length: { maximum: 100 }
	validates :salary, numericality: { only_integer: true }
	validates :travel_fees, numericality: { only_integer: true }
	validates :year, numericality: { only_integer: true }
end
