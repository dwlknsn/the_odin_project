require_relative "mastermind"
require "awesome_print"
require "pry-byebug"

human = Mastermind::HumanPlayer.new("Human Player 1")
computer = Mastermind::ComputerPlayer.new

Mastermind::Game.start(human, computer)
