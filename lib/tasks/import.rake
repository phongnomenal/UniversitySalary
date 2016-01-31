require 'csv'

namespace :import do
	desc "Import employees from csv"

	task employees: :environment do
		dir = Dir.pwd + '/lib/assets/salary_data/'

		Dir.foreach(dir) do |file_name|
			next if file_name == '.' || file_name == '..'
			
			counter = 0
			path = dir + file_name
			puts path

			CSV.foreach(path) do |row|
				# p row
				name, title, salary, travel_fees, organization, year = row
				Employee.create name: name,
												title: title,
												salary: salary,
												travel_fees: travel_fees,
												organization: organization,
												year: year

				counter += 1
				break if counter == 5
			end
		end
	end
end