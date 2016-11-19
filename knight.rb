require 'byebug'
require_relative '00_tree_node.rb'
class Knight

attr_accessor :position, :visited_positions, :root_node

  def initialize(pos)
    @position = pos
    @visited_positions = [pos]
    build_move_tree

  end


  def new_move_positions(pos)
    new_moves = valid_moves(pos)
    new_moves.reject! {|move| move if visited_positions.include?(move)}
    new_moves.each {|move| visited_positions << move}
    new_moves
  end


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

  def find_path(end_pos)
    end_node = root_node.dfs(end_pos)
    path = trace_path_back(end_node)
    p path.reverse
  end

  def trace_path_back(end_node)
    out = []
    current_node = end_node
    until current_node.parent.nil?
      out << current_node.value
      current_node = current_node.parent
    end
    out << current_node.value
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
test.find_path([3,1])
