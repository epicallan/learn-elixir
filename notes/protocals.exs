# Protocols are a mechanism to achieve polymorphism in Elixir.
# Dispatching on a protocol is available to any data type as long as it implements the protocol.

defprotocol Size do
  @doc "Calculates the size (and not the length!) of a data structure"
  def size(data)
end


defimpl Size, for: BitString do
  def size(string), do: byte_size(string)
end

defimpl Size, for: Map do
  def size(map), do: map_size(map)
end

defimpl Size, for: Tuple do
  def size(tuple), do: tuple_size(tuple)
end


# iex> Size.size("foo")
# 3
# iex> Size.size({:ok, "hello"})
# 2
# iex> Size.size(%{label: "some label"})
# 1

# Auto deriving implementation

defimpl Size, for: Any do
  def size(_), do: 0
end

defmodule OtherUser do
  @derive [Size]
  defstruct [:name, :age]
end

