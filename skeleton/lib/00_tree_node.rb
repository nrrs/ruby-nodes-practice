class PolyTreeNode
  #attr_reader :children

  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent
    @parent
  end

  def children
    @children
  end

  def value
    @value
  end

  def parent=(node)
    if !self.parent.nil?
      @parent.children.delete(self)
    end

    @parent = node
    unless @parent.nil? || @parent.children.include?(self)
      @parent.children << self
    end
  end

  def add_child(child_node)
    self.children << child_node
    child_node.parent = self
  end

  def remove_child(child_node)
    child_node.parent = nil
    raise "Not a child" unless children.include?(child_node)
  end

  def dfs(target_value)
    return self if self.value == target_value

    self.children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end

    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.concat(current_node.children)
    end
    nil
  end
  
end
