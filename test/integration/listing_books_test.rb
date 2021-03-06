require 'test_helper'

class ListingBooksTest < ActionDispatch::IntegrationTest
  setup do
    @scifi_genre = Genre.create!(name: 'Science Fiction')

    @scifi_genre.books.create!(title: 'Star Trek', rating: 5)
    @scifi_genre.books.create!(title: "Ender's Game", rating: 4)
  end

  test 'Listing books' do
    get '/api/books'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    books = json(response.body)[:books]
    assert_equal Book.count, books.size

    book = Book.find(books.first[:id])
    assert_equal @scifi_genre.id, book.genre.id
  end

  test 'Lists top rated books' do
    get '/api/books?rating=5'

    assert_equal 200, response.status
    assert_equal Mime::JSON, response.content_type

    assert_equal 1, json(response.body)[:books].size
  end
end
