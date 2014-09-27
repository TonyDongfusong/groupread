class ReadingStatusAnalyzer
  def statistic_by_user_ids(user_infos)
    p user_infos
    all_user_book_info = user_infos.map do |user_info|
      ::Thread.new do
        DoubanClient.reading_list_for_user(user_info[:douban_id]).map do |book|
          book.merge(douban_name: user_info[:douban_name])
        end
      end
    end.map(&:value).reduce(&:+)

    #{
    #    "book": Book,
    #    "book_id": "7056972",
    #    "comment": "各种成长的喜悦与痛苦，讲故事的功力比起过往短篇经典有过之而无不及，依旧是巅峰之作！",
    #    "id": 593151296,
    #    "rating": {
    #    "max": 5,
    #    "min": 0,
    #    "value": "5"
    #},
    #    "status": "read",
    #    "tags": [
    #    "吴淼",
    #    "奇幻",
    #    "中国",
    #    "塔希里亚"
    #],
    #    "updated": "2012-10-19 15:29:41",
    #    "user_id": "33388491"
    #}
    items = []
    all_user_book_info.group_by { |user_book| user_book["book_id"] }.each_pair do |book_id, user_books|
      items << {
          book_id: book_id,
          title: user_books[0]["book"]["title"],
          read_num: user_books.size,
          book_url: user_books[0]["book"]["alt"],
          read_people: user_books.map do |user_book|
            {
                name: user_book[:douban_name],
                douban_link: "http://book.douban.com/people/#{user_books[0]["user_id"]}/",
                douban_id: user_books[0]["user_id"]
            }
          end
      }
    end
    items
  end
end