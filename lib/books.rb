class Books
  attr_reader(:name, :author, :genre, :publisher, :year, :quantity, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @author = attributes.fetch(:author)
    @genre = attributes.fetch(:genre)
    @publisher = attributes.fetch(:publisher)
    @year = attributes.fetch(:year).to_i()
    @quantity = attributes.fetch(:quantity)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |books|
      name = books.fetch('name')
      author = books.fetch('author')
      genre = books.fetch('genre')
      publisher = books.fetch('publisher')
      year = books.fetch('year') 
      quantity = books.fetch('quantity')
      id = books.fetch('id')
      books.push(Books.new({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity, :id => id}))
    end
    books
  end
end
