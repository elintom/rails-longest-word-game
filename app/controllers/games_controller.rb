class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase

    if !word_in_grid?(@word, @letters)
      @message = "Use grid letters"
    elsif !valid_english_word?(@word)
      @message = "Not a valid English word"
    else
      @message = "Congratulations! #{@word} is a valid English word!"
    end
  end

  private

  def word_in_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def valid_english_word?(word)
    require "json"
    require "open-uri"
    url = "https://dictionary.lewagon.com/"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)
  end
end
