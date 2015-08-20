require('spec_helper')

describe(Books) do

  # describe('.all') do
  #   it('is empty at first') do
  #     expect(Books.all()).to(eq([]))
  #   end
  # end

  describe('#==') do
    it('is considered identical if two books are the same') do
      book1 = Books.new({:name => "A Tale of Two Cities", :author => "Charles Dickens", :genre => "historical", :publisher => "London: Chapman & Hall", :year => 1859, :quantity => 12, :id => nil})
      book2 = Books.new({:name => "A Tale of Two Cities", :author => "Charles Dickens", :genre => "historical", :publisher => "London: Chapman & Hall", :year => 1859, :quantity => 12, :id => nil})
      expect(book1).to eq(book2)
    end
  end

  describe('#save') do
    it('saves to database then outputs test book') do
      test_book = Books.new({:name => "A Tale of Two Cities", :author => "Charles Dickens", :genre => "historical", :publisher => "London: Chapman & Hall", :year => 1859, :quantity => 12, :id => nil})
      test_book.save()
      expect(Books.all()).to eq([test_book])
    end
  end

  describe('.find') do
    it('finds a book from its id') do
      test_book1 = Books.new({:name => "The God Delusion", :author => "Richard Dawkins", :genre => "non-fiction", :publisher => "Bantam Books", :year => 2006, :quantity => 2, :id => nil})
      test_book1.save()
      test_book2 = Books.new({:name => "The Call of Cthulhu", :author => "H.P. Lovecraft", :genre => "horror", :publisher => "Weird Tales", :year => 1928, :quantity => 1, :id => nil})
      test_book2.save()
      expect(Books.find(test_book2.id())).to eq(test_book2)
    end
  end

  describe('#name') do
    it('outputs name') do
      test_book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      expect(test_book.name()).to eq("1984")
    end
  end

  describe('#author') do
    it('outputs author') do
      test_book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      expect(test_book.author()).to eq("George Orwell")
    end
  end

  describe('#genre') do
    it('outputs genre') do
      test_book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      expect(test_book.genre()).to eq("dystopian")
    end
  end

  describe('#publisher') do
    it('outputs publisher') do
      test_book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      expect(test_book.publisher()).to eq("Secker & Warburg")
    end
  end

  describe('#year') do
    it('outputs year') do
      test_book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      expect(test_book.year()).to eq(1949)
    end
  end

  describe('#quantity') do
    it('outputs quantity') do
      test_book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      expect(test_book.quantity()).to eq(12)
    end
  end

  describe('#update') do
    it("lets you update a books information") do
      book = Books.new({:name => "1984", :author => "George Orwell", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12, :id => nil})
      book.save()
      book.update({:name => 'Great Expectations', :author => "Frank", :genre => "dystopian", :publisher => "Secker & Warburg", :year => 1949, :quantity => 12})
      expect(book.name()).to(eq('Great Expectations'))
    end
  end
end
