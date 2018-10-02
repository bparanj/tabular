class UserDatatable
  COLUMNS = %w(first_name last_name title city age start_date salary)
  TABLE_HEADERS = %w(first_name title city age start_date salary)
  
  def initialize(hash)
    @tabular = Tabular.new(hash)
    @search_string = []
    COLUMNS.each do |term|
    	@search_string << "#{term} like :search"
    end
  end  
  
  def data
    sort_column = TABLE_HEADERS[@tabular.sort_column]

    users = User.order("#{sort_column} #{@tabular.sort_direction}")
    users = users.limit(page_length).offset(@tabular.offset)
    users = users.where(@search_string.join(' or '), search: "%#{@tabular.search_term}%")

    result = []
    users.each do |user|
    	result << ["#{user.first_name} #{user.last_name}", user.title, user.city, user.age, "#{user.start_date.strftime('%Y/%m/%d')}", user.salary]
    end    
    result
  end
  
  def page_length
    @tabular.records_per_page
  end
  
  def records_filtered
    100
  end
  
  def records_total
    User.count
  end
end

