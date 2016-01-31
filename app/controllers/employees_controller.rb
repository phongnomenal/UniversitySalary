class EmployeesController < ApplicationController
	def index
	end


	def show
	end


	def edit
		my_input = params['my_input'].upcase
		@result = Employee.all.where(organization: my_input)
	end


	def update
	end


	private
end
