require_relative "heap"
require "byebug"
class Array
  def heap_sort!
    prc = Proc.new { |a,b| b <=> a }
    i = 0
    while i < length
      BinaryMinHeap.heapify_up(self, i, length, &prc)
      i+= 1
    end


    j = length - 1
    while j > 0
      self[0], self[j] =
        self[j], self[0]
      BinaryMinHeap.heapify_down(self, 0, j, &prc)
      j-= 1
    end

    self
  end
end
