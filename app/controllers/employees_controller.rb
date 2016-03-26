class EmployeesController < ApplicationController
	def index
		@organizations = Organization.all.order('name asc')
		# @years = Year.all.order('year desc')
		@sorts = ['Name Ascending', 'Name Descending', 
							'Salary Ascending', 'Salary Descending']
	end


	def show
	end


	def back
	end


	def edit
		name = params[:name].upcase # is "LIKE ?" case sensitive?
		title = params[:title].upcase
		sort = params[:sort_by].downcase
		@result = ""

		# match all words in name
		names = name.split(" ")
		0.upto(names.size - 1) do |i|
			if i == 0
				@result = Employee.where(year: 2015).
													 where(organization: params[:organization].upcase).
													 where("name LIKE ?", "%#{names[i]}%")
			else
				@result = @result.where("name LIKE ?", "%#{names[i]}%")
			end
		end

		# match all words in title
		if !title.blank?
			title.split(" ").each do |word|
				@result = @result.where("title LIKE ?", "%#{word}%")
			end
		end
		p sort
		# sorting
		if sort.include?('name asc')
			@result = @result.order(:name)
		elsif sort.include?('name desc')
			@result = @result.order(name: :desc)
		elsif sort.include?('salary asc')
			@result = @result.order(:salary)
		elsif sort.include?('salary desc')
			@result = @result.order(salary: :desc)
		elsif sort.include?('title asc')
			@result = @result.order(:title)
		else
			@result = @result.order(title: :desc)
		end

		# OLD CODE
		# either title or name must not be blank
		# name and title may only contain alphabet and dashes
		# \ escapes \ which escapes -
		# if (!name.blank? || !title.blank?) && name == name[/[\sA-Za-z\\-]*/]
		# 	name = name.upcase.split(/[\s,]/)
		# 	if name.size < 6
		# 		@result = Employee.where(year: params[:year]).
		# 											 where(organization: params[:organization].upcase).
		# 											 where("title LIKE ?", "%#{title}%")
    #
		# 		# name must contain all words in the search string
		# 		for i in (0 ... name.size)
		# 			@result = @result.where("name LIKE ?", "%#{name[i]}%")
		# 		end
    #
		# 		# paginated results
		# 		# @result = Employee.paginate(:page => params[:page], :per_page => 30).
		# 		# 									 where(name_query, name).
		# 		# 									 where(title_query, title).
		# 		# 									 where(organization: organization).
		# 		# 									 where(year: year)
		# 	else
		# 		puts "NAME IS SO LARGE: #{row.name}"
		# 	end
		# else
		# 	puts "NAME OR TITLE IS INVALID"
		# 	puts "TITLE = #{title[/[\sA-Za-z\\-]/]}"
		# 	puts "#{title == title[/[\sA-Za-z\\-]/]}"
		# end
	end


	def update
	end


	private
end
