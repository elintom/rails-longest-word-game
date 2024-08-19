class GamesController < ApplicationController

  def new
    @letters = Array.new { ('A'..'Z').to_a.sample }
  end

  def score
    @letters = params[:letters]
    @word = params[:word].upcase

    if !word_in_grid?(@word, @letters)
      @message = "The word can't be built out of the original grid."
    elsif !valid_english_word?(@word)
      @message = "The word is valid according to the grid, but is not a valid English word."
    else
      @message = "The word is valid according to the grid and is an English word!"
    end
  end

  private

  def word_in_grid?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end

  def valid_english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# if @question == "i am going to work"
# @answer = "Great!"
#elsif @question.end_with?("?")
#  @answer = "Silly question, get dressed and go to work!"
#else
#  @answer = "I don't care, get dressed and go to work!"
#end
