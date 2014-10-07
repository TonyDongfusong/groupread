class ReadingStatusAnalyzer
  def statistic_by_user_ids(douban_ids)
    all_user_book_info = douban_ids.map do |douban_id|
      ::Thread.new do
        {
            douban_id: douban_id,
            books: DoubanClient.reading_list_for_user(douban_id)
        }
      end
    end.map(&:value)

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
    unless all_user_book_info.nil?
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
    end
    items
  end
end