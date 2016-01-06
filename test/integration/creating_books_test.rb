require 'test_helper'

class CreatingBooksTest < ActionDispatch::IntegrationTest
  test 'create new book with valid data' do
    title = 'Pragmatic Programmer'
    rating = 5
    author = 'Dave Thomas'
    genre_id = 1
    review = 'Excellent book for any programmer.'
    amazon_id = 13123

    post '/books', { book: {
      title: title,
      rating: rating,
      author: author,
      genre_id: genre_id,
      review: review,
      amazon_id: amazon_id
    } }.to_json, { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }

    assert_equal 201, response.status
    assert_equal Mime::JSON, response.content_type

    book = json(response.body)[:book]
    assert_equal book_url(book[:id]), response.location

    assert_equal title, book[:title]
    assert_equal rating, book[:rating].to_i
    assert_equal author, book[:author]
    assert_equal genre_id, book[:genre_id].to_i
    assert_equal review, book[:review]
    assert_equal amazon_id, book[:amazon_id].to_i

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
