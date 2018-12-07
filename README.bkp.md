# Proj1

## To generate a new project in Elixir

If you are developing in Windows and use PowerShell as your CLI, here are two quick tips to prevent frustration:

The default policy is to block all scripts from executing. Since many Elixir files are scripts, you will need to change this policy to run your code. The following command will work to set your execution policy to enable scripts:

Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

The REPL for Elixir is invoked with the command iex, which coincidentally is used for a different command in PowerShell. Instead, use iex.bat, for example:

iex.bat -S mix

mix new proj1

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `proj1` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:proj1, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/proj1](https://hexdocs.pm/proj1).

## Test cases
```sh
mix run proj1.exs 3 2
3

mix run proj1.exs 40 24
1, 9, 20, 25

mix run proj1.exs 564 24
1, 9, 20, 25, 44, 76, 121, 197, 304, 353, 540

mix run proj1.exs 100 49
25

mix run proj1.exs 10000 289
20
140
199
287
433
724
1595

mix run proj1.exs 1000000 409
71752

mix run proj1.exs 1000000 4

run time scala project1.scala 1000000 4

mix run proj1.exs 100000000 20

mix run proj1.exs 100000000 24
1, 9, 20, 25, 44, 76, 121, 197, 304, 353, 540, 856, 1301, 2053
3112, 3597, 5448, 8576, 12981, 20425, 30908, 35709, 54032, 84996
128601, 202289, 306060, 353585, 534964, 841476, 1273121, 2002557
3029784, 3500233, 5295700, 8329856, 12602701, 19823373, 29991872, 34648837

mix run proj1.exs 2 24
1
```
