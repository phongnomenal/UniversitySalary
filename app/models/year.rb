class Year < ActiveRecord::Base
	# prevents duplicate years
	validates :year, uniqueness: true
end
