# Poker hands

# Problem 54
# In the card game poker, a hand consists of five cards and are ranked, from 
# lowest to highest, in the following way:

# High Card: Highest value card.
# One Pair: Two cards of the same value.
# Two Pairs: Two different pairs.
# Three of a Kind: Three cards of the same value.
# Straight: All cards are consecutive values.
# Flush: All cards of the same suit.
# Full House: Three of a kind and a pair.
# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# The cards are valued in the order:
# 2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

# If two players have the same ranked hands then the rank made up of the 
# highest value wins; for example, a pair of eights beats a pair of fives (see 
# example 1 below). But if two ranks tie, for example, both players have a pair 
# of queens, then highest cards in each hand are compared (see example 4 
# below); if the highest cards tie then the next highest cards are compared, 
# and so on.

# Consider the following five hands dealt to two players:

# Hand	 	Player 1	 	Player 2	 	Winner
# 1	 	5H 5C 6S 7S KD
# Pair of Fives
#  	2C 3S 8S 8D TD
# Pair of Eights
#  	Player 2
# 2	 	5D 8C 9S JS AC
# Highest card Ace
#  	2C 5C 7D 8S QH
# Highest card Queen
#  	Player 1
# 3	 	2D 9C AS AH AC
# Three Aces
#  	3D 6D 7D TD QD
# Flush with Diamonds
#  	Player 2
# 4	 	4D 6S 9H QH QC
# Pair of Queens
# Highest card Nine
#  	3D 6D 7H QD QS
# Pair of Queens
# Highest card Seven
#  	Player 1
# 5	 	2H 2D 4C 4D 4S
# Full House
# With Three Fours
#  	3C 3D 3S 9S 9D
# Full House
# with Three Threes
#  	Player 1
# The file, poker.txt, contains one-thousand random hands dealt to two players.
# Each line of the file contains ten cards (separated by a single space): the 
# first five are Player 1's cards and the last five are Player 2's cards. You 
# can assume that all hands are valid (no invalid characters or repeated 
# cards), each player's hand is in no specific order, and in each hand there is 
# a clear winner.

# How many hands does Player 1 win?


##############################################################################
##  UNFINISHED
### This one is just really complicated and I'm running out of steam to work on
### it.
##############################################################################

# Global constants for suits
Suit = struct.new(:name, :color)

CLUBS = Suit.new("Clubs", "Black")
DIAMONDS = Suit.new("Diamonds", "Red")
HEARTS = Suit.new("Hearts", "Red")
SPADES = Suit.new("Spades", "Black")

SUITS = [CLUBS, DIAMONDS, HEART, SPADES]

# Global constants for pips
Pip = struct.new(:name, :rank)

TWO = Pip.new("Two", 1)
THREE = Pip.new("Three", 2)
FOUR = Pip.new("Four", 3)
FIVE = Pip.new("Five", 4)
SIX = Pip.new("Six", 5)
SEVEN = Pip.new("Seven", 6)
EIGHT = Pip.new("Eight", 7)
NINE = Pip.new("Nine", 8)
TEN = Pip.new("Ten", 9)
JACK = Pip.new("Jack", 10)
QUEEN = Pip.new("Queen", 11)
KING = Pip.new("King", 12)
ACE = Pip.new("Ace", 13)

PIPS = [
  TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE, TEN, JACK, QUEEN, KING, ACE
]

class String
  def to_card
    pips = self[0]
    suit = self[1]
    
    pip_values = {
      "2" => TWO,
      "3" => THREE,
      "4" => FOUR,
      "5" => FIVE,
      "6" => SIX,
      "7" => SEVEN,
      "8" => EIGHT,
      "9" => NINE,
      "10" => TEN,
      "J" => JACK,
      "Q" => QUEEN,
      "K" => KING,
      "A" => ACE
    }

    suits = {
      "C" => CLUBS,
      "D" => DIAMONDS,
      "H" => HEARTS,
      "S" => SPADES
    }

    Card.new(pip_value[pips], suits[suit])
  end

  def to_hand
    cards = self.split(" ").map(&:to_card)
    Hand.new(cards)
  end
end

class Card
  attr_accessor :suit, :pips, :color, :rank
  
  def initialize(suit, pips)
    self.suit = suit
    self.pips = pips
    self.color = suit.color
    self.rank = pips.rank
  end

  def to_s
    self.pips.name + " of " + self.suit.name
  end

  def >(other)
    self.pip.rank > other.pip.rank
  end

  def <(other)
    self.pip.rank < other.pip.rank
  end

  def ==(other)
    self.pip == other.pip and self.suit == other.suit
  end
end

class Hand
  attr_accessor :cards
  
  def initalize(cards)
    self.cards = cards.sort
  end

  def rank_hand
    return self.cards if flush? or straight?
    return kind_hand(4) if four_of_a_kind?
    return 
  end

  # Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
  def royal_flush?
    straight? and flush? and self.cards[0] == TEN
  end

  # Straight Flush: All cards are consecutive values of same suit.
  def straight_flush?
    flush? and straight?
  end

  def kind(pip)
    self.cards.select {|c| c.pips == pip}
  end

  def kind_hand(n)
    PIPS.each do |pip|
      matching = kind(pip)
      return matching if matching.length == n
    end
  end

  def of_a_kind?(n)
    false
  end

  # Four of a Kind: Four cards of the same value.
  def four_of_a_kind?
    # Lol, for a second I was wondering why there's five-of-a-kind
    of_a_kind?(4)
  end

  def two_kind_hand()
  end

  # Largest group should come first
  def two_kinds?(large_n, small_n)
    large_group, small_group = [], []
    
    PIPS.each do |pip|
      matches = kind(pip)
      break large_group = matches if matches.length == large_n
    end
    
    return false if large_group.empty?
    leftovers = self.cards - large_group
    
    return PIPS.any? do |pip|
      leftovers.select {|c| c.pips == pip}.length == small_n
    end

    return false
  end

  # Full House: Three of a kind and a pair.
  def full_house?
    two_kinds?(3, 2)
  end

  # Flush: All cards of the same suit.
  def flush?
    SUITS.any? do |suit| 
      self.cards.all? {|card| card.suit == SUIT}
    end
  end

  # Straight: All cards are consecutive values.
  def straight? # assumes sorted
    start = self.cards.first.rank
    self.cards.all?.with_index {|card, i| card.rank == start + 1}
  end

  # Three of a Kind: Three cards of the same value.
  def three_of_a_kind?
    of_a_kind?(3)
  end

  # Two Pairs: Two different pairs.
  def two_pairs?
    two_kinds?(2, 2)
  end

  # One Pair: Two cards of the same value.
  def one_pair?
    of_a_kind?(2)
  end

  def high_card # Assumes sorted
    self.cards[-1]
  end
end

class Round
  attr_accessor :player1_hand, :player2_hand
  
  def initialize(player1_hand, player2_hand)
    self.player1_hand = player1_hand
    self.player2_hand = player2_hand
  end
  
  def winner
    # High Card: Highest value card.
# One Pair: Two cards of the same value.
# Two Pairs: Two different pairs.
# Three of a Kind: Three cards of the same value.
# Straight: All cards are consecutive values.
# Flush: All cards of the same suit.
# Full House: Three of a kind and a pair.
# Four of a Kind: Four cards of the same value.
# Straight Flush: All cards are consecutive values of same suit.
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
    hand_ranks = [
      :royal_flush?, 
      :straight_flush?, 
      :four_of_a_kind?, 
      :full_house?, 
      :flush?,
      :three_of_a_kind?,
      :straight?,
      :flush?,
      :full_house?,
      :four_of_a_kind?,
      :straight_flush?,
      :royal_flush?
    ]

    hand_ranks.any? do |rank|
      if self.player1_hand.send(:rank) and self.player2_hand.send(:rank)
    end
  end
end