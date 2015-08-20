require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('add a book to the catalog', {:type => :feature}) do
  it('adds a book to the catalog') do
    visit ('/books')
    fill_in('name', :with => "The Two Towers")
    fill_in('author', :with => "J. R. R. Tolkien")
    fill_in('publisher', :with => "George Allen & Unwin")
    fill_in('genre', :with => "Fantasy")
    fill_in('year', :with => 1954)
    fill_in('quantity', :with => 4)
    click_button('Add book')
    expect(page).to have_content('The Two Towers')
  end
end

describe('add a patron to the library database', {:type => :feature}) do
  it('adds a patron to the database') do
    visit ('/patrons')
    fill_in('name', :with => "Billy Bob")
    fill_in('phone', :with => 666-6666)
    fill_in('city', :with => "Austin")
    fill_in('zip', :with => 78909)
    fill_in('age', :with => 123)
    #fill_in('checkout', :with => 'A Tale of Two Cities')
    click_button('Add patron')
    expect(page).to have_content('Billy Bob')
  end
end
