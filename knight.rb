require 'byebug'
require_relative '00_tree_node.rb'
class Knight

attr_accessor :position, :visited_positions, :possible_pos, :parent, :root_node, :visited_nodes

  def initialize(pos)
    @position = pos
    @visited_positions = [pos]
    build_move_tree

  end


  def new_move_positions(pos)
    new_moves = valid_moves(pos)
    p "visited_pos #{visited_positions}"
    p "og array #{new_moves}"
    new_moves.reject! {|move| move if visited_positions.include?(move)}
    new_moves.each {|move| visited_positions << move}
    new_moves
  end

  # def new_move_positions(pos)
  #   valid_moves(pos)
  #     .reject { |new_pos| visited_positions.include?(new_pos) }
  #     .each { |new_pos| visited_positions << new_pos }
  # end

  def build_move_tree
   #debugger
   self.root_node = PolyTreeNode.new(position)

   queue = [root_node]
    until queue.empty?
      current_node = queue.shift
      current_pos = current_node.value
      new_move_positions(current_pos).each do |move_pos|
        new_node = PolyTreeNode.new(move_pos)
        current_node.add_child(new_node)
        queue << new_node
      end
    end
  end




  def valid_moves(pos)
    valid_moves = []
    long = [-2,2]
    short = [1,-1]
    valid_moves += valid_moves_helper(pos, long, short)
    valid_moves += valid_moves_helper(pos, short, long)
  end

  def valid_moves_helper(pos, arr1, arr2)
    x,y = pos
    valid_moves = []
    arr1.each do |move|
      arr2.each do |move2|
        new_pos = [x + move, y + move2]
        valid_moves << new_pos if inbounds?(new_pos)
      end
    end
    valid_moves
  end

  def inbounds?(pos)
    x,y = pos
    x.between?(0,7) && y.between?(0,7)
  end


end

test = Knight.new([0,0])
