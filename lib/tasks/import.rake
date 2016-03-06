require 'csv'

namespace :import do
	desc "Import salary data from csv"

	# Use the below command to import the salary data:
	# bundle exec rake import:employees
	task employees: :environment do
		dir = Dir.pwd + '/lib/assets/salary_data/'

		Dir.foreach(dir) do |file_name|
			next if file_name == '.' || file_name == '..'

			path = dir + file_name
			puts path
		
			csv = CSV.read path # skip the first row
			csv.shift
			csv.each do |row|
				name, title, salary, travel_fees, organization, year = row
				Employee.create name: name,
												title: title,
												salary: salary.to_i,
												travel_fees: travel_fees.to_i,
												organization: organization,
												year: year.to_i
			end # csv
		end # Dir
	end # task employees

	# universities
	task organizations: :environment do
		dir = Dir.pwd + '/lib/assets/salary_data/'
		Dir.foreach(dir) do |file_name|
			next if file_name == '.' || file_name == '..'
			path = dir + file_name
			csv = CSV.read path
			csv.shift # skip the first row
			csv.each do |row|
				name, title, salary, travel_fees, organization, year = row
				org = ""
				words = organization.split
				n = words.size - 1
  			0.upto n do |i|
  				words[i].upcase == "OF" ? words[i].downcase! : words[i].capitalize!
  				org += i < n ? words[i] + " " : words[i]
  			end
				Organization.create name: org
				break
			end # csv
		end # Dir
	end # task organizations

	# fiscal year
	task years: :environment do
		years = [2015]
		years.each do |y|
			Year.create year: y
		end # years
	end # task years

end # namespace