require_relative 'heap'

def k_largest_elements(array, k)

  i = 0
  while i < array.length
    BinaryMinHeap.heapify_up(array, i, array.length)
    i+= 1
  end


  j = array.length - 1
  while j > 0
    array[0], array[j] =
      array[j], array[0]
    BinaryMinHeap.heapify_down(array, 0, j)
    j-= 1
  end

  array[0...k]
end
