require 'open-uri'
require 'nokogiri'

class SearchMovies
  attr_reader :movies, :list_imdb

  def initialize(query)
    @movies = []
    @list_imdb = []

    load_site(query)
    load_movies
  end

  private

  def load_site(query)
    query = query.gsub(' ', '%20')
    @document = Nokogiri::HTML(URI.open("https://www.imdb.com/find?q=#{query}&s=tt&ttype=ft"))
  end

  def load_movies
    @document.search('table[class="findList"] tr').each do |tr|
      imdb = imdb_value(tr)
      title = tr.at('td.result_text a').content
      url_cover = tr.at('td.primary_photo a img').attr('src')
      year = year_value(tr)

      @movies.append({ imdb: imdb, title: title, url_cover: url_cover, year: year })
      @list_imdb.append(imdb)
    rescue
      next
    end
  end

  def imdb_value(table)
    imdb = table.at('td.result_text a').attr('href')
    imdb = imdb.split('/title/')[1]
    imdb.split('/')[0]
  end

  def year_value(table)
    year = table.at('td.result_text').content
    year = year.split('(')[1]
    year = year.split(')')[0]
    Integer(year)
  end
end
