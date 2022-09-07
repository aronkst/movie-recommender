require 'open-uri'
require 'base64'
require 'nokogiri'

class GetMovie
  attr_accessor :imdb, :title, :year, :summary, :score, :amount_of_votes, :metascore, :points, :genres,
                :recommended_movies, :url_cover

  def initialize(imdb)
    @imdb = imdb

    load_site

    @score = score_value
    @amount_of_votes = amount_of_votes_value
    @metascore = metascore_value
    @points = calculate_points
    @title = title_value
    @year = year_value
    @summary = summary_value
    @genres = genres_value
    @url_cover = url_cover_value
    @recommended_movies = recommended_movies_value

    raise 'movie from imdb is invalid' if invalid?
  end

  private

  def invalid?
    @url_cover.nil? || @score.nil? || @year.nil? || @amount_of_votes.nil? || @amount_of_votes <= 0 ||
      @genres.blank? || @recommended_movies.blank? || @summary.blank? || @summary == 'Add a Plot »' ||
      @document.search('ul[data-testid="hero-title-block__metadata"] li').count != 3
  end

  def load_site
    @document = Nokogiri::HTML(URI.open("https://www.imdb.com/title/#{@imdb}/"))
  end

  def title_value
    title = @document.at('script[type="application/ld+json"]').text
    title = title.split('"name":"')[1]
    title.split('",')[0]
  rescue StandardError
    nil
  end

  def year_value
    year = @document.search('ul[data-testid="hero-title-block__metadata"] li[role="presentation"]')[0]
    year = year.at('a').text
    year.to_i
  rescue StandardError
    nil
  end

  def summary_value
    summary = @document.at('script[type="application/ld+json"]').text
    summary = summary.split('"description":"')[1]
    summary.split('",')[0]
  rescue StandardError
    nil
  end

  def score_value
    score = @document.at('script[type="application/ld+json"]').text
    score = score.split(',"aggregateRating":{"')[1]
    score = score.split('},"')[0]
    score = score.split(',"ratingValue":')[1]
    score.to_f
  rescue StandardError
    nil
  end

  def amount_of_votes_value
    amount_of_votes = @document.at('script[type="application/ld+json"]').text
    amount_of_votes = amount_of_votes.split(',"aggregateRating":{"')[1]
    amount_of_votes = amount_of_votes.split('},"')[0]
    amount_of_votes = amount_of_votes.split(',"ratingCount":')[1]
    amount_of_votes = amount_of_votes.split(',"bestRating":')[0]
    amount_of_votes.to_i
  rescue StandardError
    nil
  end

  def metascore_value
    metascore = @document.at('span[class="score-meta"]').text
    metascore.to_i
  rescue StandardError
    0
  end

  def calculate_points
    if @metascore <= 0
      (@score * @amount_of_votes).to_i
    else
      (((@score + (@metascore / 10)) / 2) * @amount_of_votes).to_i
    end
  rescue StandardError
    nil
  end

  def genres_value
    genres = @document.at('script[type="application/ld+json"]').text
    genres = genres.split(',"genre":[')[1]
    genres = genres.split('],"')[0]
    genres = genres.gsub('"', '')
    genres.split(',')
  rescue StandardError
    nil
  end

  def url_cover_value
    url_cover = @document.at('script[type="application/ld+json"]').text
    url_cover = url_cover.split('"image":"')[1]
    url_cover.split('",')[0]
  rescue StandardError
    nil
  end

  def recommended_movies_value
    recommended_movies = []
    @document.search('div[class*="ipc-poster-card "]').each do |recommended_movie|
      recommended_movie = recommended_movie.at('a[class="ipc-lockup-overlay ipc-focusable"]').attr('href')
      recommended_movie = recommended_movie.split('/title/')[1]
      recommended_movie = recommended_movie.split('/?')[0]
      recommended_movies.push(recommended_movie)
    end

    recommended_movies
  rescue StandardError
    nil
  end
end
