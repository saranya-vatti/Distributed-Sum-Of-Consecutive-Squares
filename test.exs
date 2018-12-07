
defmodule App do
  def main do
    n = 82457176
    k = 24
    IO.inspect first_squares(82457176)
    IO.inspect first_squares(82457199)
    IO.inspect first_squares(82457199) - first_squares(82457175)
    IO.inspect :math.sqrt(first_squares(82457199) - first_squares(82457175))
    IO.inspect square
  end

  def square(n\\(82457175)) do
    if(n==82457200)
      sum
    else
      n*n+square(n+1)
    end
  end

  def isPerfectSquare?(n) do
    num = :math.sqrt(n)
    num == trunc(num)
  end

  @doc """
  A recursive function that sums the consecutive squares starting and ending at some random integers
  Start should always be less than end; else the function just returns the square of the starting integer.
  """
  def sum_of_consecutive_squares(st, en) do
    # IO.puts "summing from #{st} to #{en}"
    cond do
      st <= 0 or en <= 0 ->
        0
      st >= en ->
        st * st
      true ->
        first_squares(en) - first_squares(st-1)
    end
  end

  def first_squares(num) do
    div((num * (num + 1) * (2*num + 1)), 6)
  end

end

App.main
