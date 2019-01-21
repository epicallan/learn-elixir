defmodule User do
  defstruct name: "John", age: 27
end

# defstruct define whats fields that will exist in a struct

# Access structs

# iex> %User{}
# %User{age: 27, name: "John"}
# iex> %User{name: "Jane"}
# %User{age: 27, name: "Jane"}
