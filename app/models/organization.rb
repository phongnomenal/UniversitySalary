class Organization < ActiveRecord::Base
	# has_many :employees

	# prevents duplicate orginanizations
	validates :name, uniqueness: true
end
