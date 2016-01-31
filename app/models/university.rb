class University < ActiveRecord::Base
	# ordering by name
	# scope by_name order(:name)

	# enforces name to be the primary key
	validates :name, uniqueness: true
end
