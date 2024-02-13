require_relative 'tic_tac_toe'

player1 = TicTacToe::Player.new("Player1")
player2 = TicTacToe::Player.new("Player2")

game = TicTacToe::Game.new([player1, player2])

game.start
