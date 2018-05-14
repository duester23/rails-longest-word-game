
require 'open-uri'
require 'json'

class GameController < ApplicationController
  def new
    @letters = generate_grid(10);
  end

   def score
    @letters = params[:letters]
    @word = params[:word]
    @included = included?(@word, @letters)
    @english = english_word?(@word)
  end

  def generate_grid(grid_size)
    Array.new(grid_size) { ('A'..'Z').to_a.sample }
  end

  def included?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
