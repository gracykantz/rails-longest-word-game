require 'open-uri'
require 'json'

class GamesControllerController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    attempt = params[:attempt]
    grid = params[:grid]
    dictionary_url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    # parse JSON to check if attempt is valid && grid
    word = JSON.parse(open(dictionary_url).read)
    @results = {}
    if word['found'] && in_grid?(attempt.upcase, grid)
      @results[:message] = 'well done'
      @results[:score] = word.length.fdiv((Time.now + 1 - Time.now) * 0.5)
    elsif word['found'] == false
      @results[:message] = 'not an english word'
      @results[:score] = 0
    else
      @results[:message] = 'not in the grid'
      @results[:score] = 0
    end

    if session.key?(:score)
      session[:score] += @results[:score]
    else
      session[:score] = @results[:score]
    end
    @total_score = session[:score]
  end

  def in_grid?(attempt, grid)
    attempt.chars.all? { |char| attempt.count(char) <= grid.count(char) }
  end
end
