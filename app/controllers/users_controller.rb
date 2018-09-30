class UsersController < ApplicationController
  def index
		tabular = Tabular.new(params)
		
		search_string = []
		columns = %w(first_name last_name title city age start_date salary)
		columns.each do |term|
			search_string << "#{term} like :search"
		end

		table_headers = %w(first_name title city age start_date salary)
		sort_column = table_headers[tabular.sort_column]
		users = User.order("#{sort_column} #{tabular.sort_direction}")
		users = users.limit(tabular.records_per_page).offset(tabular.offset)
		users = users.where(search_string.join(' or '), search: "%#{tabular.search_term}%")
		records_filtered = users.count
		
		data = []
		users.each do |user|
			data << ["#{user.first_name} #{user.last_name}", user.title, user.city, user.age, "#{user.start_date.strftime('%Y/%m/%d')}", user.salary]
		end
				
		render json: {
			"pageLength": tabular.records_per_page,
			"recordsTotal": User.count,
			"recordsFiltered": 100,
			"data": data
		}
  end
end
