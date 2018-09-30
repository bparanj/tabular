require 'minitest/autorun'

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

describe Tabular do
  	
	it 'should convert the string to integer for start' do
	  tabular = Tabular.new(first_page_parameters)
    start = tabular.start		
    
    assert_equal 0, start
	end

	it 'should convert the string to integer for length' do
	  tabular = Tabular.new(first_page_parameters)
    length = tabular.length		
    
    assert_equal 10, length
	end
	
  it 'should default to 10 records per page if length parameter is negative' do
    tabular = Tabular.new(all_pages)
    records_per_page = tabular.records_per_page
    
    assert_equal 10, records_per_page
  end
  
  it 'records per page can be customized' do
    tabular = Tabular.new(custom_number_of_pages)
    records_per_page = tabular.records_per_page
    
    assert_equal 20, records_per_page
  end
  
  it 'should calculate the page number for first page' do
    tabular = Tabular.new(first_page_parameters)  
    page_number = tabular.page_number
    
    assert_equal 1, page_number
  end

  it 'should calculate the page number for second page' do
    tabular = Tabular.new(second_page_parameters)  
    page_number = tabular.page_number
    
    assert_equal 2, page_number
  end
  
  it 'should parse the sort column' do
    tabular = Tabular.new(first_page_parameters)
    sort_column = tabular.sort_column
    
    assert_equal 0, sort_column
  end
  
  it 'should parse the sort direction' do
    tabular = Tabular.new(first_page_parameters)
    sort_direction = tabular.sort_direction
    
    assert_equal 'asc', sort_direction  
  end
  
  it 'should parse the search term' do
    tabular = Tabular.new(search_parameters)
    search_term = tabular.search_term
    
    assert_equal 'Testing', search_term
  end
  
  it 'page offset is 0 for first page' do
    tabular = Tabular.new(first_page_parameters)
    offset = tabular.offset
    
    assert_equal 0, offset    
  end
  
  it 'page offset is 10 for the second page with 10 records per page' do
    tabular = Tabular.new(second_page_parameters)
    offset = tabular.offset
    
    assert_equal 10, offset        
  end
  
	def first_page_parameters
    {
    	"draw" => "3", 
      "columns" => {
    		"0" => {
    			"data" => "0", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "1" => {
    			"data" => "1", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "2" => {
    			"data" => "2", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "3" => {
    			"data" => "3", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "4" => {
    			"data" => "4", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "5" => {
    			"data" => "5", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}
    	}, 
      "order" => {
    		"0" => {
    			"column" => "0", "dir" => "asc"
    		}
    	}, 
      "start" => "0", 
      "length" => "10", 
      "search" => {
    		"value" => "", "regex" => "false"
    	}, "_" => "1538204747378"
    }
	end
  
  def all_pages
    {
      "start" => "0", 
      "length" => "-1", 
      "search" => {
    		"value" => "", "regex" => "false"
    	}, "_" => "1538204747378"
    }
  end
  
  def custom_number_of_pages
    {
      "start" => "0", 
      "length" => "20"
    }
  end
  
  def second_page_parameters
    {
    	"draw" => "2", 
      "columns" => {
    		"0" => {
    			"data" => "0", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "1" => {
    			"data" => "1", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "2" => {
    			"data" => "2", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "3" => {
    			"data" => "3", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "4" => {
    			"data" => "4", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}, "5" => {
    			"data" => "5", "name" => "", "searchable" => "true", "orderable" => "true", "search" => {
    				"value" => "", "regex" => "false"
    			}
    		}
    	}, 
      "order" => {
    		"0" => {
    			"column" => "0", "dir" => "asc"
    		}
    	}, 
      "start" => "10", 
      "length" => "10", 
      "search" => {
    		"value" => "", "regex" => "false"
    	}, "_" => "1538204747377"
    }
  end
  
  def search_parameters
    {
      "search" => {
    		"value" => "Testing", "regex" => "false"
    	}
    }
  end
end