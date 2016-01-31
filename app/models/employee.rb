class Employee < ActiveRecord::Base
	# enforce "primary key" = [name, org, year]
	# because names are unique within each org (not realistic but this is what we are given)
	validates :name, uniqueness: {scope: [:organization, :year]}
end
