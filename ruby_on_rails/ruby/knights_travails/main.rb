require_relative "lib/game"

game = Game.new(8, [0, 0], [7, 7])
game.solve

game = Game.new(8, [0, 0], [2, 6])
game.solve

game = Game.new(8, [1, 3], [4, 7])
game.solve

game = Game.new(8, [6, 5], [2, 2])
game.solve

game = Game.new(10, [0, 0], [9, 9])
game.solve

game = Game.new(15, [0, 0], [14, 14])
game.solve

game = Game.new(15, [0, 0], [14, 14])
game.solve
