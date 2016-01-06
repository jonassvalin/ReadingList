require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'create new book with valid data' do
    title = 'Pragmatic Programmer'
    rating = 5

    post '/books', { book: {
      title: title,
      rating: rating
    } }.to_json, { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    book = json(response.body)
    assert_equal book_url(book[:id]), response.location

    assert_equal title, book[:title]
    assert_equal rating, book[:rating].to_i
  end

  test 'does not create valid data' do
    title = nil
    rating = 5

    post '/books', { book: {
      title: title,
      rating: rating
    } }.to_json, { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    assert_equal 422, response.status
    assert_equal Mime::JSON, response.content_type
  end
end
