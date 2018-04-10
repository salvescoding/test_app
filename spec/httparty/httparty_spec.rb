describe 'HTTParty' do
  it 'Get request', vcr: { cassette_name: 'jsonplaceholder/posts'} do
      response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/1")
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
  end

  it 'Get with URL not determined', vcr: { cassette_name: 'jsonplaceholder/posts',
    match_requests_on: [:body] }  do
    response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/#{[1,2,3,4].sample}")
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
  end

  # When you want to VCR save into a new file a different request instead of giving an error
  it 'Get request - saving into a new record', vcr: { cassette_name: 'jsonplaceholder/posts',
    :record => :new_episodes} do
      response = HTTParty.get("https://jsonplaceholder.typicode.com/posts/3")
      content_type = response.headers['content-type']
      expect(content_type).to match(/application\/json/)
  end


end
