class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc ||= Proc.new { |a,b| a <=> b }
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    result = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, @store.length)
    result
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    @store = BinaryMinHeap.heapify_up(@store, @store.length - 1, @store.length)
  end

  public
  def self.child_indices(len, parent_index)
    first = parent_index * 2 + 1
    second = parent_index * 2 + 2
    result = []
    result.push(first) if first < len
    result.push(second) if second < len

    return result

  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    return (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)


    prc ||= Proc.new { |a,b| a <=> b }
    parent_i = parent_idx
    int = false
    until int
      int = true
      # parent_i = 0 if parent_i == len - 1 || parent_i == len - 2
      children = self.child_indices(len, parent_i)
      first_cond = children[1] ? prc.call(array[children[1]], array[children[0]]) >= 0 : true
      break if children.empty?
      if first_cond && prc.call(array[parent_i], array[children[0]]) >= 1
        array[parent_i], array[children[0]] =
          array[children[0]], array[parent_i]
        parent_i = children[0]
        int = false
      elsif !first_cond && prc.call(array[parent_i], array[children[1]]) >= 1
        array[parent_i], array[children[1]] =
          array[children[1]], array[parent_i]
        parent_i = children[1]
        int = false
      end
    end

    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |a,b| a <=> b }
    child_i = child_idx

    int = false
    until int
      int = true
      break if child_i == 0
      parent_idx = self.parent_index(child_i)
      parent = array[parent_idx]
      child = array[child_i]
      if prc.call(parent, child) >= 1
        array[parent_idx], array[child_i] =
          array[child_i], array[parent_idx]
        child_i = parent_idx
        int = false
      end
    end
    return array
  end
end
