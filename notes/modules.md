Summary Notes
___

Alias
___

All modules defined in Elixir are defined inside the main Elixir namespace. However, for convenience, you can omit “Elixir.” when referencing them.

eg `List is from Elixir.List`

Alias usage

```
defmodule Stats do
  alias Math.List, as: List
  # In the remaining module definition List expands to Math.List.
  # this is also same as
  alias Math.List
  # in which List alias Math.List
end

```

Aliases expand to atoms because in the Erlang VM (and consequently Elixir) modules are always represented by atoms

For instance, the String alias translates by default to the atom :"Elixir.String":


Require
___

Require is for invoking Macros

```
iex> require Integer
Integer
iex> Integer.is_odd(3)
true
```

Import
____

This is for accessing function or macros from other modules without
using fully qualified names

eg

```
ex> import List, only: [duplicate: 2]
List
iex> duplicate :ok, 3
[:ok, :ok, :ok]
```

Import can also be used to import all macros or functions

```
import Integer, only: :macros

import Integer, only: :functions

```

Use
___

Is another way of importing modules into functions

```
defmodule Example do
  use Feature, option: :value
end

defmodule Example do
  require Feature
  Feature.__using__(option: :value)
end

```

Multi alias/import/require/use
__

 Imagine you have an application where all modules are nested under MyApp, you can alias the modules MyApp.Foo, MyApp.Bar and MyApp.Baz at once as follows:

 ```elixir
 alias MyApp.{Foo, Bar, Baz}

 ```

 Annotations
___

Documentation with annotations
___

```elixir

defmodule Math do
  @moduledoc """
  Provides math-related functions.

  ## Examples

      iex> Math.sum(1, 2)
      3

  """

  @doc """
  Calculates the sum of two numbers.
  """
  def sum(a, b), do: a + b
end

```

Module attributes as constants
___

```elixir
defmodule MyServer do
  @initial_state %{host: "127.0.0.1", port: 3456}
  IO.inspect @initial_state
end

```
