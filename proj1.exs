defmodule ConsecutiveSquares do

  @moduledoc """
  ConsecutiveSquares module
  An interesting problem in arithmetic with deep implications to elliptic curve
  theory is the problem of finding perfect squares that are sums of consecutive
  squares.
  The goal of this first project is to use Elixir and the actor model to build a
  good solution to this problem that runs well on multi-core machines.
  """

  def main do
    # Parses the input from command line and initializes the supervisor.

    command_line_args = System.argv()
    if length(command_line_args) < 2 do
      raise ArgumentError, message: "there must be at least two arguments: n and k"
    end
    [n, k | _tail] = command_line_args
    [n, k] = Enum.map([n, k], fn(n) ->
      try do
        n |> String.trim_trailing |> String.to_integer
      rescue
        ArgumentError -> IO.puts("n and k must be integers. Defaulting #{n} to 1")
        1
      end
    end)
    init([n, k])
  end

  @doc """
  Gets the worker size with the maximum optimum threads as 10000 based on trial and error.
  This is the size of the problem set that each solution will run
  """
  def get_worker_size(n) do
    cond do
      n <= 1000 -> 1
      n <= 10000 -> 100
      n <= 100000 -> 1000
      true -> 10000
    end
  end

  def get_num_of_children(n) do
    worker_size = get_worker_size(n)
    num_of_children = div(n, worker_size)
    num_of_children = if rem(n, worker_size) == 0, do: num_of_children, else: num_of_children+1
    num_of_children
  end

  @doc """
   Main work like the supervisor is done here - a number of child processes are spawned,
   each of which solves a small part or batch of the problem
  """
  def init([n, k]) do

    # Research paper proven: http://oeis.org/A001032
    # Only for the following k does the problem have any output. Added 4 and 20 to test
    if k in [1, 2, 4, 11, 20, 23, 24, 26, 33, 47, 49, 50, 59, 73, 74, 88, 96, 97, 107, 121, 122, 146, 169, 177, 184, 191, 193, 194, 218, 239, 241, 242, 249, 289, 297, 299, 311, 312, 313, 337, 338, 347, 352, 361, 362, 376, 383, 393, 407, 409, 431, 443, 457, 458, 479, 481, 491, 506] do
      num_of_children = get_num_of_children(n)
      IO.puts "Number of child processes : #{num_of_children}"
      worker_size = get_worker_size(n)
      IO.puts "Worker size : #{worker_size}"
      Enum.map(1..num_of_children, fn(child_num) ->
        start = ((child_num - 1) * worker_size) + 1
        #en = min((start + worker_size - 1), n)
        en = start + worker_size - 1
        spawn(Worker, :init, [start, en, k, self()])
      end)
      listen(n, k, num_of_children)
    end

  end

  @doc """
    A recursive listen that makes sure the parent is alive as long as any of the child processes are running
    Since we have a counter of the number of child processes we are spawning, we keep a global counter to check if all the processes we spawned have exited before stopping listening.
  """
  def listen(n, k, global_counter, start_time\\System.monotonic_time()) do
    receive do
      {:exit} ->
        global_counter = global_counter - 1
        if (global_counter > 0) do
          listen(n, k, global_counter, start_time)
        else
          end_time = System.monotonic_time()
          IO.puts "Time taken : #{end_time - start_time}"
        end
    end
  end
end

defmodule Worker do
  @moduledoc """
  This is the Worker module where the actual computation happens.
  When the worker is initialized, it starts off the validation
  """
  def init(batch_start, batch_end, k, parent_pid) do
    # IO.puts "batch_start = #{batch_start} and batch_end = #{batch_end}"
    all_consecutive_sum_to_perfect_sq(batch_start, batch_end, k, parent_pid)
  end

  @doc """
   This validates each of the numbers if they are the start points of
  the k consecutive squares that add up to perfect square, as we are looking for.
  """
  def all_consecutive_sum_to_perfect_sq(st, en, k, parent_pid) do
    if (sum_of_consecutive_squares(st, st + k - 1) |> isPerfectSquare?) do
      IO.puts st
    end
    if st < en do
      all_consecutive_sum_to_perfect_sq(st + 1, en, k, parent_pid)
    else
      send(parent_pid, {:exit})
    end
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
    div(num * (num + 1) * (2*num + 1), 6)
  end

  @doc """
   Small function that validates whether the given number is a perfect square
  """
  def isPerfectSquare?(n) do
    sqrt = :math.sqrt(n)
    sqrt - :erlang.trunc(sqrt) == 0
  end
end


# Kickstarting the main function.
ConsecutiveSquares.main
