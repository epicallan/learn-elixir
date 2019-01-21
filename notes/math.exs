defmodule Math do
  def sum(a, b) do
    a + b
  end
  def zero?(0), do: true
  def zero?(x) when is_integer(x), do: false
end

defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end

end

IO.puts Math.sum(1, 2)
IO.puts Math.zero?(01)
IO.puts Concat.join("hello", "world")
