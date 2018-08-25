require_relative 'node'

class Knight
  attr_reader :parent, :pos
  def initialize(pos)
    @pos = pos
    @possible_moves = possible_moves(pos)
  end
  
  def possible_moves(pos)
    possible_moves = []
    
    right_up = [2, 1]
    right_left = [2, -1]
    left_up = [-2, 1]
    left_down = [-2, -1]
    up_right = [1, 2]
    up_left = [-1, 2]
    down_right = [1, -2]
    down_left = [-1, -2]
    
    possible_moves = [right_up, right_left, left_up, left_down, up_right, up_left, 
    down_right, down_left]
    
    pos_moves = possible_moves.select { |move| valid_move?(pos, move) }
    pos_moves.map {|move| add_coordinates(@pos, move) }
    

  end

  
  def valid_move?(pos,move)
    possible_move = add_coordinates(pos, move)
    return false unless possible_move.first >= 0 && possible_move.first <= 7
    return false unless possible_move.last >= 0 && possible_move.last <= 7
    true
  end
  
  def add_coordinates(pos_arr, move_arr)
    x, y = pos_arr
    x2, y2 = move_arr
    [x + x2, y + y2]
  end
  
  def distance(pos, target_pos)
    x , y = pos
    x2, y2 = target_pos
    
    x_distance = (x2-x).abs
    y_distance = (y2-y).abs
    
    x_square = x_distance * x_distance
    y_square = y_distance * y_distance
    sum = x_square + y_square
    
    return Math.sqrt(sum)
  end
  
  def create_children(target)
    queue = [self]
    puts "Self: #{self.pos}"
    
    
    node_distances = []
    node_hash = {}
    until @possible_moves.include?(target)
      @possible_moves.each do |move|
        child_node = Knight.new(move)
        child_node.create_children(target)
        node_distances.push(distance(move, target))
        node_hash[node_distances.min] = child_node
      end
      debugger
      closest_min = node_hash.keys.sort.last
      best_child = node_hash[closest_min]
      puts "Best child:#{best_child}"
      best_child.create_children(target)
    end
    
    self
  end
  

end


if __FILE__ == $PROGRAM_NAME
  x = Knight.new([0,0])
  p x
end

# def [](pos)
#   x, y = pos 
# end