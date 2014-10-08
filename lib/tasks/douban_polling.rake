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
                             book_id: raw_book["book_id"].to_i
                         })
    end

    read_record = ReadRecord.find_by_book_id_and_user_id(book.id, user.id)
    if read_record.nil?
      read_record = ReadRecord.create({
                                          status: raw_book["status"],
                                          rating: (not raw_book["rating"].nil? and not raw_book["rating"]["value"].nil?) ? raw_book["rating"]["value"].to_i : 0
                                      })
    end

    read_record.user = user
    read_record.book = book
    read_record.save
  end
end

task :poll_douban do
  user_ids = User.all.map(&:id)
  user_ids.map do |user_id|
    ::Thread.new do
      user = User.find(user_id)
      unless user.douban_auth_info.nil?
        poll_from_douban_and_fill_in_db(user, user.douban_auth_info.douban_user_id)
      end
    end
  end.map(&:value)
end