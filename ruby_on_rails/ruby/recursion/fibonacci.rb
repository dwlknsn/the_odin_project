def fibs(n)
  arr = []

  0.upto(n) do |i|
    arr[i] =
      if i == 0 || i == 1
        i
      else
        arr[i - 1] + arr[i - 2]
      end
  end

  arr
end

p fibs(10)

def fibs_rec(n)
  if n == 0
    arr = [0]
  elsif n == 1
    arr = [0, 1]
  else
    arr = fibs_rec(n-1)
    arr << arr[-1] + arr[-2]
  end

  arr
end

p fibs_rec(10)
