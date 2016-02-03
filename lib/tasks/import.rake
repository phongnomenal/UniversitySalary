require 'csv'

namespace :import do
	desc "Import employees from csv"

	# Use the below command to import the salary data:
	# bundle exec rake import:employees
	task employees: :environment do
		dir = Dir.pwd + '/lib/assets/salary_data/'

		Dir.foreach(dir) do |file_name|
			next if file_name == '.' || file_name == '..'
			
			# counter = 0
			path = dir + file_name
			puts path
			
			# skip the first row
			csv = CSV.read path
			csv.shift
			csv.each do |row|
				# p row
				name, title, salary, travel_fees, organization, year = row
				Employee.create name: name,
												title: title,
												salary: salary.to_i,
												travel_fees: travel_fees.to_i,
												organization: organization,
												year: year.to_i
				# counter += 1
				# break if counter == 5
			end
		end
	end
end