# Scrape data from ibdb.com

require 'nokogiri'
require 'open-uri'
# require 'pry'

class Scraper
    def initialize
        @links
        @musicals = []
    end

    def get_links
        page = Nokogiri::HTML(open('https://www.ibdb.com/shows'))
        @links = page.css(".xt-iblock-inner").collect { |l| l.css("a")[0]["href"] }
    end
    
    def get_musical(musical)
        url = "https://www.ibdb.com" + musical
        page = Nokogiri::HTML(open(url))
        title = page.css(".title-label").text
        open_date = page.css(".xt-fixed-block").css(".xt-main-title").first.text
        music = page.css("#ProductionStaff").css("div:nth-child(7)").css("a:nth-child(2)")[0].text
        @musicals << { title: title, open_date: open_date, music: music }
    end

    def get_musicals
        get_links
        @links.slice(0, 13).each { |l| get_musical(l) }
        @musicals
    end

end