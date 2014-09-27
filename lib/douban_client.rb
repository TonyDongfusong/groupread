class DoubanClient
  include HTTParty

  base_uri 'https://www.douban.com'
  @@api_key = "0e26ec484bf14ac42a74c4d8e3d3e04c"
  @@secret = "cd25719372221342"
  @@callback_url = "http://localhost:3000/oauth_callback"

  def new
    @oauth_url = "https://www.douban.com/service/auth2/auth?client_id=#{@@api_key}\
&redirect_uri=#{@@callback_url}&response_type=code&"
  end

  def create
    code = params[:code]
    response = self.class.post("/service/auth2/token?client_id=#{@@api_key}&client_secret=#{@@secret}\
&grant_type=authorization_code&redirect_uri=#{@@callback_url}&code=#{code}")
    auth_response = JSON.parse(response.body)

    book_resp = self.class.get("http://api.douban.com/v2/book/user/#{auth_response["douban_user_id"]}/collections")
    p book_resp.body
    book_json = JSON.parse(book_resp.body)
    filtered = book_json["collections"].map do |book|
      {
          status: book["status"],
          title: book["title"]
      }
    end
    render json: filtered
  end
end

