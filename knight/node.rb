require 'byebug'

class Node

  attr_reader :parent, :children, :value
  
  def initialize(val)
    @parent = nil
    @children = []
    @value = val
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
  
    if node==nil
      @parent = nil
      return
    end
  
    if parent.nil?
      @parent = node
      @parent.children.push(self)
    else
      @parent.children.delete(self)
      @parent = node
      @parent.children.push(self)
    end
    
  end
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise "#{child_node} is not a child" unless @children.include?(child_node)
    child_node.parent = nil
  end
  
  def inspect
    self.value
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    
    self.children.each do |child|
      child_search = child.dfs(target_value)
      return child_search unless child_search.nil?
    end
    nil
  end
  
  def bfs(target_value)
    queue = [self]
  
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      queue += node.children
    end
  end
end