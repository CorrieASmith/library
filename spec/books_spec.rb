require('spec_helper')

describe(Books) do

  describe('.all') do
    it('is empty at first') do
      expect(Books.all()).to(eq([]))
    end
  end
end
