class PolyTreeNode

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
    
end