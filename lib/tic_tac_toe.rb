# frozen_string_literal: true

# Game: Tic Tac Toe

class Board
  @@board = { C1R1: '_', C2R1: '_', C3R1: '_',
              C1R2: '_', C2R2: '_', C3R2: '_',
              C1R3: '_', C2R3: '_', C3R3: '_' }

  def self.display
    puts
    puts '     C1  C2  C3'
    puts
    puts "R1   _#{@@board[:C1R1]}_|_#{@@board[:C2R1]}_|_#{@@board[:C3R1]}_"
    puts "R2   _#{@@board[:C1R2]}_|_#{@@board[:C2R2]}_|_#{@@board[:C3R2]}_"
    puts "R3   _#{@@board[:C1R3]}_|_#{@@board[:C2R3]}_|_#{@@board[:C3R3]}_"
    puts
  end

  def self.full?
    @@board.none? { |_position, mark| mark == '_' }
  end
end

class Player < Board
  attr_reader :name, :mark, :marked

  attr_accessor :winner

  @@players = []

  def initialize(name, mark)
    @name = name
    @mark = mark
    @marked = []
    @winner = false
    @@players << self
  end

  def mark_on_board
    position = gets.chomp.upcase

    if /^C[123]R[123]$/.match?(position)
      if @@board[position.to_sym] == '_'
        @@board[position.to_sym] = @mark
        @marked << position

      elsif @marked.include?(position)
        puts 'You have already marked this space.'
        Board.display
        print "#{@name} ('#{@mark}'), choose an empty one: "
        mark_on_board

      else
        puts 'This space has already been marked.'
        Board.display
        print "#{@name} ('#{@mark}'), choose another one: "
        mark_on_board
      end

    else
      puts 'Wrong syntax.'
      Game.help
      print "#{@name} ('#{@mark}'), try again: "
      mark_on_board
    end
  end

  def self.all
    @@players
  end
end

class Game < Player
  @@ways_to_win = [
    %w[C1R1 C2R1 C3R1],
    %w[C1R2 C2R2 C3R2],
    %w[C1R3 C2R3 C3R3],
    %w[C1R1 C1R2 C1R3],
    %w[C2R1 C2R2 C2R3],
    %w[C3R1 C3R2 C3R3],
    %w[C1R1 C2R2 C3R3],
    %w[C3R1 C2R2 C1R3]
  ]

  def self.info
    puts
    puts 'Game: Tic-tac-toe'
    puts
    puts 'Tic-tac-toe is played on a three-by-three grid by two players,'
    puts "who alternately place the marks 'X' and 'O' in one of the nine"
    puts 'spaces in the grid.'
    puts
    puts "Player 1's mark is 'X' and Player 2's mark is 'O'."
    puts 'The player who succeeds in placing three of their marks in a'
    puts 'horizontal, vertical, or diagonal row is the winner.'
    puts
  end

  def self.help
    puts
    puts 'The syntax to place your mark on the board is "C[123]R[123]" where'
    puts '"C" stands for Column and "R" for Row; [123] means to type 1, 2 or 3.'
    puts '(e.g., "C1R2" places your mark in the first column and second row)'
    Board.display
  end

  def self.winner?
    @@players.each do |player|
      @@ways_to_win.each do |way|
        if way.all? { |position| player.marked.include?(position) }
          player.winner = true
          return true
        end
      end
    end
    false
  end
end

# Game.info
# Game.help
# 
# Player.new('Player 1', 'X')
# Player.new('Player 2', 'O')
# 
# until Game.winner? || Board.full?
#   Player.all.each do |player|
#     print "#{player.name} ('#{player.mark}') turn: "
#     player.mark_on_board
#     Board.display
#     break if Game.winner? || Board.full?
#   end
# end
# 
# if Board.full?
#   puts "It's a draw!"
# else
#   Player.all.each do |player|
#     puts "#{player.name} ('#{player.mark}') won!" if player.winner == true
#   end
# end
