
rails g model user first_name last_name title city age:integer start_date:date salary

## Parameters from Client

Clicking on the first page, we see the parameters are:

{
	"draw" => "3", "columns" => {
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
	}, "order" => {
		"0" => {
			"column" => "0", "dir" => "asc"
		}
	}, "start" => "0", "length" => "10", "search" => {
		"value" => "", "regex" => "false"
	}, "_" => "1538204747378"
}

Clicking on the second page, we see the parameters are:

 {
 	"draw" => "2", "columns" => {
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
 	}, "order" => {
 		"0" => {
 			"column" => "0", "dir" => "asc"
 		}
 	}, "start" => "10", "length" => "10", "search" => {
 		"value" => "", "regex" => "false"
 	}, "_" => "1538204747377"
 }
 
 The parameters relevant to pagination are the start and length. According the [Datatables Server-side Processing](https://datatables.net/manual/server-side) docs, start is:
 
 >> Paging first record indicator. This is the start point in the current data set (0 index based - i.e. 0 is the first record).
 
and the length is:
 
 >> Number of records that the table can display in the current draw. It is expected that the number of records returned will be equal to this number, unless the server has fewer records to return. 
 
 We also see the column ordering asc or desc. We must return atleast three parameters, recordsTotal, recordsFiltered and data as described in the docs (https://datatables.net/manual/server-side#Returned-data). 
 
We must convert the string to integer for start and length in the params.
 
 params['start'].to_i
 params['length'].to_i

We have learned enough by reading the Datatables documentation and looking at the Rails console the params sent by the client to start writing tests. Let's document these requirements as tests:

```ruby
require 'minitest/autorun'

class Tabular
  def initialize(params)
    @params = params
  end

  def start
    @params['start'].to_i
  end
  
  def length
    @params['length'].to_i
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
	
	def first_page_parameters
    {
    	"draw" => "3", "columns" => {
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
    	}, "order" => {
    		"0" => {
    			"column" => "0", "dir" => "asc"
    		}
    	}, "start" => "0", "length" => "10", "search" => {
    		"value" => "", "regex" => "false"
    	}, "_" => "1538204747378"
    }
	end
end
```
 
Rails will allow us to use symbols instead of string:
 
 params[:start].to_i
 params[:length].to_i

This is a minor change, we can tackle it towards the end. Let's focus on the requirements that is independent of the Rails framework. This allows us to write tests outside of Rails framework.

## Pages

 We can default to 10 records per page if length parameter is negative (this will be the case for returning all the records, we don't want that to happen). The corresponding tests and the code to implement the requirements:
 
```ruby
require 'minitest/autorun'

class Tabular
    
  def records_per_page
    length = @params['length'].to_i
    length > 0 ? length : DEFAULT_RECORDS_PER_PAGE
  end
  
  def page_number
    @params['start'].to_i / records_per_page + 1
  end
end

describe Tabular do
  	  
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
end
```

## Sort
 
 Sort column is in order parameter: 

params['order']
 => {"0"=>{"column"=>"0", "dir"=>"asc"}}
  
In this case, we only have one column:

 params['order']['0']['column']
  => "0"

 Sort direction: 
 
 params['order']['0']['dir']
 => "asc" 

In this case, the first column is in ascending order. We can use this in ActiveRecord:

users = User.order("#{sort_column} #{sort_direction}")

We can add the tests for it:

```ruby
  it 'should parse the sort column' do
    tabular = Tabular.new(first_page_parameters)
    sort_column = tabular.sort_column
    
    assert_equal '0', sort_column
  end
  
  it 'should parse the sort direction' do
    tabular = Tabular.new(first_page_parameters)
    sort_direction = tabular.sort_direction
    
    assert_equal 'asc', sort_direction  
  end
```

The implementation is simple:

```ruby
  def sort_column
    @params['order']['0']['column']
  end
  
  def sort_direction
    @params['order']['0']['dir']
  end
```


## Searching
 
To handle the search term entered in the search text field, we can retrieve the value entered:

params['search']['value']

search key consists of the hash: {"value"=>"", "regex"=>"false"} 

The value will be blank string when it is not a search request. The tests and the implementation are shown below:

```ruby
  it 'should parse the search term' do
    tabular = Tabular.new(search_parameters)
    search_term = tabular.search_term
    
    assert_equal 'Testing', search_term
  end
```

```ruby
  def search_term
    @params['search']['value']
  end
```


## Offset

With 1 page having 10 items:

page 1 will have items 1 - 10
page 2 ............... 11 - 20
page 3 ............... 21 - 30

Page 1 offset = 0
Page 2 offset = 10
Page 3 offset = 20

The tests:

```ruby
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
```

The implementation to calculate offset:

```ruby
  def offset
    (page_number - 1) * records_per_page
  end
```

## Pagination

We can limit by:

users = users.limit(per_page)

We can define, RECORDS_PER_PAGE = 10 and chain the offset with limit:

users = users.limit(per_page).offset(page_number * RECORDS_PER_PAGE), we can now get data for the data section of the JSON response from the server without using Kaminari gem:


```ruby
 def fetch_users
    search_string = []
    columns.each do |term|
      search_string << "#{term} like :search"
    end

    users = User.order("#{sort_column} #{sort_direction}")
    users = users.limit(per_page).offset(offset)
    users = users.where(search_string.join(' or '), search: "%#{params[:search][:value]}%")
  end

  def columns
    %w(name email city)
  end


  def as_json(options = {})
    {
      recordsTotal: User.count,
      recordsFiltered: 'count the number of records after applying where conditions',
      data: data
    }
  end

From Datatables forum thread:
	
>> The "recordsFiltered" has a value different of "recordsTotal". The "recordsFiltred" is the number of items after globalSearch or columnSearch. If there is no search (globalSearch or columnSearch) , then the value "recordsFiltered" is equal to "recordsTotal".

From Datatables docs:

>> recordsFiltered is the total number of records in the data set after filtering - not just the data array length (which DataTables can do itself!). So if you have no filtering recordsFiltered should be exactly the same as recordsTotal

Implementing Datatables without Kaminari gives developers who are working on projects where they don't have the freedom to choose or upgrade the existing pagination gems. 

## References
 
- [Datatables Server-side Processing](https://datatables.net/manual/server-side)
- [Drifting Ruby Datatables](https://www.driftingruby.com/episodes/datatables)
