class PagesController < ApplicationController
	def home
		@organizations = Organization.all.order('name asc')
		@years = Year.all.order('year desc')
		@sorts = ['Name Ascending', 'Name Descending', 
							'Salary Ascending', 'Salary Descending']
	end
end
