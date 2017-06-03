require_relative '../skeleton/lib/00_tree_node'

class KnightPathFinder

  DELTAS = [
    [1, 2],
    [2, 1],
    [2, -1],
    [1, -2],
    [-1, -2],
    [-2, -1],
    [-2, 1],
    [-1, 2]
  ]

  def self.valid_moves(pos)
    valid_moves_array = []
    x, y = pos

    # check if move is within valid confines
    DELTAS.each do |delta|
      valid_moves_array << [x + delta.first, y + delta.last]
    end

    # check if move is within board confines
    available_moves = valid_moves_array.select do |el|
      el.first.between?(0, 7) && el.last.between?(0, 7)
    end

    available_moves
  end

  def new_move_positions(pos)
    move_pos = self.class.valid_moves(pos).reject { |el| @visited_pos.include?(el) }
    # p "before + move #{@visited_pos}"
    # @visited_pos += move_pos
    # p "after + move #{@visited_pos}"
    move_pos
  end

  def initialize(starting_pos = [0,0])
    @starting_node = PolyTreeNode.new(starting_pos)
    @visited_pos = [@starting_node.value]
  end

  def build_move_tree
    queue = [@starting_node]
    until queue.empty?
      current_node = queue.shift
      kids = new_move_positions(current_node.value)

      kids.each do |pos|
        current_node.add_child(PolyTreeNode.new(pos))
      end

      add_to_queue = current_node.children

      add_to_queue.each do |child|
        child_pos = child.value
        queue.push(child) unless @visited_pos.include?(child_pos)
        @visited_pos.push(child_pos)
      end
    end
    nil
  end

  def find_path(target)
    @starting_node.bfs(target)
  end

  def trace_path_back(target)
    result = []

    answer = find_path(target)
    until answer.value == @starting_node.value

      result << answer.value
      answer = answer.parent
    end
    result << @starting_node.value
    p result.reverse
  end

end

if __FILE__ == $PROGRAM_NAME
  game = KnightPathFinder.new
  game.build_move_tree
  p game.trace_path_back([7,6])
end
