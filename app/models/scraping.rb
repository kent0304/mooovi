# class Scraping
#   def self.movie_urls
#     # 映画の個別ページのURLを取得
#     # get_product(link)を呼び出す
#     links =[]
#     agent = Mechanize.new

#     # パスの部分を変数で定義
#     next_url = ""

#     while true do
#       page = agent.get("http://review-movie.herokuapp.com/" + next_url)
#       details = page.search(".entry-title a")
#       details.each do |detail|
#         links << detail.get_attribute("href")
#       end
#       #次へを表すタグを取得
#       next_link = page.at(".pagination .next").inner_text if page.at(".pagination .next")

#       #next_linkがなかったらwhile文を抜ける
#       unless page.at(".pagination .next")
#         exit
#       end

#       # そのタグからhref属性の値を取得
#       next_url = page.at(".pagination .next")[:href] if page.at(".pagination .next")

#     end

#     links.each do |link|
#       get_product("http://review-movie.herokuapp.com/" + link)
#     end
#   end

#   def self.get_product(link)
#     # 作品名と作品画像のURLをスクレイピング
#     # スクレイピングした二つのデータをProductsテーブルに保存
#     agent = Mechanize.new
#     elements = agent.get(link)
#     image_url = elements.at(".entry-content img")[:src] if elements.at(".entry-content img")
#     title = elements.at(".entry-title").inner_text

#       product = Product.where(title: title, image_url: image_url).first_or_initialize
#       product.save

#   end
# end

#-------------------------------------------------------------------

# class Scraping
#   def self.movie_urls
#     links = []
#     agent = Mechanize.new
#     next_url = ""

#     while true
#       current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
#       elements = current_page.search('.entry-title a')
#       elements.each do |ele|
#         links << ele.get_attribute('href')
#       end

#       next_link = current_page.at('.pagination .next a')
#       break unless next_link
#       next_url = next_link.get_attribute('href')

#     end
#     links.each do |link|
#       get_product('http://review-movie.herokuapp.com' + link)
#     end
#   end

#   def self.get_product(link)
#     agent = Mechanize.new
#     page = agent.get(link)
#     title = page.at('.entry-title').inner_text if page.at('.entry-title')
#     image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
#     director = page.at(".review_details .director span").inner_text if page.at(".review_details .director span")
#     detail = page.at(".entry-content p").inner_text if page.at(".entry-content p")
#     open_date = page.at(".review_details .date span").inner_text if page.at(".review_details .date span")


#     product = Product.where(title: title).first_or_initialize
#     product.image_url = image_url
#     product.director = director
#     product.detail = detail
#     product.open_date = open_date
#     product.save
#   end
# end
class Scraping
  def self.movie_urls
    links = []
    agent = Mechanize.new
    next_url = ""

    while true
      current_page = agent.get("http://review-movie.herokuapp.com/" + next_url)
      elements = current_page.search('.entry-title a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end

      next_link = current_page.at('.pagination .next a')
      break unless next_link
      next_url = next_link.get_attribute('href')

    end
    links.each do |link|
      get_product('http://review-movie.herokuapp.com' + link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text if page.at('.entry-title')
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')
    director = page.at('.director span').inner_text if page.at('.director span')
    detail = page.at('.entry-content p').inner_text if page.at('.entry-content p')
    open_date = page.at('.date span').inner_text if page.at('.date span')

    product = Product.where(title: title).first_or_initialize
    product.image_url = image_url
    product.director  = director
    product.detail = detail
    product.open_date = open_date
    product.save
  end
end




