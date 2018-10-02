The index.html contains the single page front-end app that interacts with the Rails backend. We can use live-server to run this single page app. You can see how by reading this article: (https://rubyplus.com/articles/5581-How-to-Quickly-Create-Web-App-Prototypes). Read the article [Tabular](https://rubyplus.com/articles/5601-Datatables-Basics) for more details.


https://datatables.net/manual/server-side
https://datatables.net/manual/server-side#Returned-data
https://editor.datatables.net/examples/inline-editing/simple

http://blog.josephmisiti.com/sorting-booleans-in-jquery-datatables


# Sorting admin column
# Sort direction: asc ----> admin users + normal users
# else normal users + admin users

# Turn off search for admin column

$('#example').dataTable( {
  "columnDefs": [
    { "searchable": false, "targets": 0 }
  ]
} );