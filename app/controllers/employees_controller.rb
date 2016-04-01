class EmployeesController < ApplicationController
	def index
		@organizations = Organization.all.order('name asc')
		# @years = Year.all.order('year desc')
		@sorts = ['Name Ascending', 'Name Descending', 
							'Salary Ascending', 'Salary Descending']

		@result = ""

		# match all words in name
		names = params[:name].upcase.split(" ") # is "LIKE ?" case sensitive?
		organization = params[:organization].upcase
		0.upto(names.size - 1) do |i|
			if i == 0
				# Hard coding the year
				@result = Employee.where(year: 2015).where(organization: organization)
													.where("name LIKE ?", "%#{names[i]}%")
			else
				@result = @result.where("name LIKE ?", "%#{names[i]}%")
			end
		end

		# match all words in title
		titles = params[:title].upcase.split(" ")
		if !titles.blank?
			titles.each do |t|
				@result = @result.where("title LIKE ?", "%#{t}%")
			end
		end

		# sort by the selected option
		# sort_by = params[:sort_by].upcase
		sort_by = 'NAME ASC'
		if sort_by.include?('NAME ASC')
			@result = @result.order(:name)
		elsif sort_by.include?('NAME DESC')
			@result = @result.order(name: :desc)
		elsif sort_by.include?('SALARY ASC')
			@result = @result.order(:salary)
		elsif sort_by.include?('SALARY DESC')
			@result = @result.order(salary: :desc)
		elsif sort_by.include?('TITLE ASC')
			@result = @result.order(:title)
		elsif sort_by.include?('TITLE DESC')
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

end
