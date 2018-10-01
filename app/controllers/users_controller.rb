class UsersController < ApplicationController
  def index
		data_table = UserDatatable.new(params)
		
		render json: {
			"pageLength": data_table.page_length,
			"recordsTotal": data_table.records_total,
			"recordsFiltered": data_table.records_filtered,
			"data": data_table.data
		}
  end
end
