require "douban_client"

module UsersHelper
  def douban_oauth_url
    DoubanClient.oauth_url
  end
end
