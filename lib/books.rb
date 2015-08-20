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

  define_singleton_method(:find) do |id|
    Books.all().each() do |book|
      if book.id() == id
        return book
      end
    end
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @author = attributes.fetch(:author)
    @year = attributes.fetch(:year)
    @publisher = attributes.fetch(:publisher)
    @genre = attributes.fetch(:genre)
    @quantity = attributes.fetch(:quantity)
    @id = self.id()
    DB.exec("UPDATE books SET name = '#{@name}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET author = '#{@author}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET year = #{@year} WHERE id = #{@id};")
    DB.exec("UPDATE books SET publisher = '#{@publisher}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET genre = '#{@genre}' WHERE id = #{@id};")
    DB.exec("UPDATE books SET quantity = #{@quantity} WHERE id = #{@id};")
  end

  #checkout method?
    #finds book
    #@quantity -=1
    #Patron @checked_out.push
  #end checkout
end
