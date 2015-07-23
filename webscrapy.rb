require 'nokogiri'
require 'open-uri'
require 'mechanize'


class RedditScraper
  
  def initialize
    @headline = []
    @agent = Mechanize.new
  end
  def fetch_reddit_headlines
    mech_page = @agent.get("http://news.kicks.cn/plus/list.php?tid=12&TotalResult=3147&PageNo=1")
    num_pages_to_scrape = 5
    count = 1
    number = 1
    number2 = 1
    fp = File.new("shoes.txt", "w")
    fp.write("\n\nReferences\n\n")
    while(num_pages_to_scrape > count)
      html = mech_page.body
      html_doc = Nokogiri::HTML(html)
      list = html_doc.xpath("//a[@class='title']/b")
      list.each { |i|  fp.write(i.text + "\n");puts "#{number}#{i.text}";number +=1}
      #page = mech_page.parser
      #puts page
      fp.write("\n\nLink\n\n")
      list = html_doc.xpath("//a[@class='title']/@href")
      list.each { |i| fp.write("http://news.kicks.cn#{i.text}" + "\n");puts "#{number2}http://news.kicks.cn#{i.text}";number2 +=1}
      count += 1
      mech_page = @agent.get("http://news.kicks.cn/plus/list.php?tid=12&TotalResult=3147&PageNo=#{count}")
    end
  end
end
r = RedditScraper.new
r.fetch_reddit_headlines
