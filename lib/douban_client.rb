class DoubanClient
  include HTTParty

  @@base_uri = 'https://www.douban.com'
  @@api_key = "0e26ec484bf14ac42a74c4d8e3d3e04c"
  @@secret = "cd25719372221342"
  @@callback_url = $callback_url

  def self.oauth_url
    "https://www.douban.com/service/auth2/auth?client_id=#{@@api_key}\
&redirect_uri=#{@@callback_url}&response_type=code&"
  end

  def self.token_auth code
    response = HTTParty.post(@@base_uri + "/service/auth2/token?client_id=#{@@api_key}&client_secret=#{@@secret}\
&grant_type=authorization_code&redirect_uri=#{@@callback_url}&code=#{code}")
    return {status: response.code, message: response.message} if response.code != 200

    {
        status:response.code,
        auth_info: JSON.parse(response.body)
    }
  end

  def self.reading_list_for_user(douban_user_id)
    response = HTTParty.get("https://api.douban.com/v2/book/user/#{douban_user_id}/collections")
    JSON.parse(response.body)["collections"]
  end
end

