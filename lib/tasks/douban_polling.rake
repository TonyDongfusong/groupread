require File.expand_path('../../../config/environment', __FILE__)
require File.expand_path('../../douban_client', __FILE__)


# @param [User] user
# @param [String] douban_user_id
def poll_from_douban_and_fill_in_db(user, douban_id)
  DoubanClient.reading_list_for_user(douban_id).each do |raw_book|
    book = Book.find_by_book_id(raw_book["book_id"].to_i)
    if book.nil?
      book = Book.create({
                    title: raw_book["book"]["title"],
                    image: raw_book["book"]["image"],
                    url: raw_book["book"]["alt"],
                    book_id: raw_book[:book_id].to_i
                  })
    end
    unless book.users.include? user
      book.users << user
      book.save
    end
  end
end

task :poll_douban do
  User.all.map do |user|
    unless user.douban_auth_info.nil?
      poll_from_douban_and_fill_in_db(user, user.douban_auth_info.douban_user_id)
    end
  end
end