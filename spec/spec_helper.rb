require('rspec')
require('books')
require('patrons')
require('pg')

DB = PG.connect({:dbname => 'library'})

# RSpec.configure do |config|
#   config.after(:each) do
#     DB.exec("DELETE FROM books *;")
#     DB.exec("DELETE FROM patrons *;")
#   end
# end
