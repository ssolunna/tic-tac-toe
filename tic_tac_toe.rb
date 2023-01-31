# Game: Tic Tac Toe

class Board
  @@board = { C1R1: "_", C2R1: "_", C3R1: "_",
              C1R2: "_", C2R2: "_", C3R2: "_",
              C1R3: "_", C2R3: "_", C3R3: "_" }

  def Board.display
    puts "     C1  C2  C3\n\n"
    puts "R1   _#{@@board[:C1R1]}_|_#{@@board[:C2R1]}_|_#{@@board[:C3R1]}_"
    puts "R2   _#{@@board[:C1R2]}_|_#{@@board[:C2R2]}_|_#{@@board[:C3R2]}_"
    puts "R3   _#{@@board[:C1R3]}_|_#{@@board[:C2R3]}_|_#{@@board[:C3R3]}_"
  end
end

class Player < Board
  attr_reader :name, :mark
  
  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def mark_on_board(position)
    @@board[position] = @mark
  end
end

