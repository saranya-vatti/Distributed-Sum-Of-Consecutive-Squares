defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  setup do
    {:ok,server_pid} = Stack.start_link(5)
    {:ok,server: server_pid}
  end

  test "push and pop success test", %{server: pid} do
    assert :ok == Stack.push(pid,6)
    assert :ok == Stack.push(pid,7)
    assert :ok == Stack.push(pid,8)
    assert 5 == Stack.pop(pid)
    assert 6 == Stack.pop(pid)
    assert 7 == Stack.pop(pid)
  end
end
