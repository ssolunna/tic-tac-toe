# Game: Tic Tac Toe

class Board
  @@board = { C1R1: '_', C2R1: '_', C3R1: '_',
              C1R2: '_', C2R2: '_', C3R2: '_',
              C1R3: '_', C2R3: '_', C3R3: '_' }

  def self.display
    puts "     C1  C2  C3\n\n"
    puts "R1   _#{@@board[:C1R1]}_|_#{@@board[:C2R1]}_|_#{@@board[:C3R1]}_"
    puts "R2   _#{@@board[:C1R2]}_|_#{@@board[:C2R2]}_|_#{@@board[:C3R2]}_"
    puts "R3   _#{@@board[:C1R3]}_|_#{@@board[:C2R3]}_|_#{@@board[:C3R3]}_"
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
    @@board[position.to_sym] = @mark
    @marked << position
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

Player.new('Player 1', 'X')
Player.new('Player 2', 'O')

until Game.winner?
  Player.all.each do |player|
    print "#{player.name} ('#{player.mark}') turn: "
    player.mark_on_board
    puts
    Board.display
    puts
    break if Game.winner?
  end
end
