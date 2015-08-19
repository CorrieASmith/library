require('spec_helper')

describe(Patrons) do

  describe('.all') do
    it('is empty at first') do
      expect(Patrons.all()).to(eq([]))
    end
  end
end
