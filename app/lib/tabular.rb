class Tabular
  DEFAULT_RECORDS_PER_PAGE = 10
  
  def initialize(params)
    @params = params
  end

  def start
    @params['start'].to_i
  end
  
  def length
    @params['length'].to_i
  end
  
  def records_per_page
    length = @params['length'].to_i
    length > 0 ? length : DEFAULT_RECORDS_PER_PAGE
  end
  
  def page_number
    @params['start'].to_i / records_per_page + 1
  end
  
  def sort_column
    @params['order']['0']['column'].to_i
  end
  
  def sort_direction
    @params['order']['0']['dir']
  end
  
  def search_term
    @params['search']['value']
  end
  
  def offset
    (page_number - 1) * records_per_page
  end
end