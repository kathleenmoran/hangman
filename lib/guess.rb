# frozen_string_literal: true

# a guess of a single character in the word, made by the player
class Guess
  attr_reader :value

  def initialize(value)
    @value = value.downcase
  end

  def eql?(other)
    @value == other.value
  end

  def hash
    @value.to_i
  end

  def to_s
    @value
  end

  def valid?
    @value.length == 1 && @value.match(/[a-z]/)
  end

  def save_request?
    @value.downcase == 'save'
  end

  def exit_request?
    @value.downcase == 'exit'
  end

  def request?
    save_request? || exit_request?
  end
end
