class EmployeesController < ApplicationController
	def index
		@organizations = Organization.all.order(:name)
		@years = Year.all.order('year desc')
	end


	def show
	end


	def edit
		# format the name according to whether which name was provided
		name = ""
		if params[:first_name].blank?
			name = params[:last_name].upcase
		elsif params[:last_name].blank?
			name = params[:first_name].upcase
		else
			name = "#{params[:last_name]},#{params[:first_name]}".upcase
		end
		exact_name = params[:exact_name]

		title = params[:title].upcase
		exact_title = params[:exact_title]

		organization = params[:organization].upcase
		year = params[:year]

		# build the query logic for name and title
		# name must not be blank and the exact checkbox must be checked
		name_query = ''
		if !name.blank? && exact_name != '0'
			name_query = "name = ?"
		else
			name_query = "name LIKE ?"
			name = "%#{name}%"
		end

		title_query = ''
		if !title.blank? && exact_title != '0'
			title_query = "title = ?"
		else
			title_query = "title LIKE ?"
			title = "%#{title}%"
		end

		# get the result
		@result = Employee.all.where(name_query, name).
													 where(title_query, title).
													 where(organization: organization).
													 where(year: year)
													 # debug
	end


	def update
	end


	private
end
