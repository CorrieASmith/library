require('pry')

class Books
  attr_reader(:name, :author, :genre, :publisher, :year, :quantity, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @author = attributes.fetch(:author)
    @genre = attributes.fetch(:genre)
    @publisher = attributes.fetch(:publisher)
    @year = attributes.fetch(:year).to_i()
    @quantity = attributes.fetch(:quantity).to_i()
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_books = DB.exec("SELECT * FROM books;")
    books = []
    returned_books.each() do |book|
      name = book.fetch('name')
      author = book.fetch('author')
      genre = book.fetch('genre')
      publisher = book.fetch('publisher')
      year = book.fetch('year')
      quantity = book.fetch('quantity')
      id = book.fetch('id').to_i()
      books.push(Books.new({:name => name, :author => author, :genre => genre, :publisher => publisher, :year => year, :quantity => quantity, :id => id}))
    end
    books
  end

  define_method(:==) do |other|
    self.id().eql?(other.id())
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO books (name, author, genre, publisher, year, quantity) VALUES ('#{@name}','#{@author}', '#{@genre}','#{@publisher}', #{@year}, #{@quantity}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end
end
