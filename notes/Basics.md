# Summary notes

Keyword Lists
____

These are lists with tuples, where the key is an atom

```
iex> list = [{a:, 1}, {b:, 2}]
```

keyword lists can also be written in special syntax as below

```
iex> list = [a: 1, b:, 2]
```

keyword lists are used in Elixir mainly for passing optional values.


Maps
____

Key value store

```
iex> map = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}
```

Maps are good for pattern matching

```
iex> %{} = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}
iex> %{:a => a} = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}
iex> a
1
iex> map = %{:a => 1, 2 => :b}
%{2 => :b, :a => 1}


iex> %{map | 2 => "two"} # updating key value
%{2 => "two", :a => 1}
iex> %{map | :c => 3}

# When all the keys in a map are atoms, you can use the keyword syntax # for convenience

iex> map = %{a: 1, b: 2}
%{a: 1, b: 2}

# when accessing atom keys
iex> map.a
1

```

Nexted Maps and lists

```

iex> users = [
  john: %{name: "John", age: 27, languages: ["Erlang", "Ruby", "Elixir"]},
  mary: %{name: "Mary", age: 29, languages: ["Elixir", "F#", "Clojure"]}
]

# accessing a value
iex> users[:john].age

# updating  a value
iex> users = put_in users[:john].age, 31

```

Function capturing
_________
short form for creating functions


```
iex> fun = &(&1 + 1)
iex> fun.(1)
2

iex> fun = &List.flatten(&1, &2)
&List.flatten/2
iex> fun.([1, [[2], 3]], [4, 5])
[1, 2, 3, 4, 5]
```

`&List.flatten(&1, &2) is the same as writing fn(list, tail) -> List.flatten(list, tail) end`

Default arguments
_______

```
defmodule Concat do
  def join(a, b, sep \\ " ") do
    a <> sep <> b
  end
end

IO.puts Concat.join("Hello", "world")      #=> Hello world
IO.puts Concat.join("Hello", "world", "_") #=> Hello_world

```

Recursion
_________

summing a list of numbers with recursion

```
defmodule Math do
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end
end

IO.puts Math.sum_list([1, 2, 3], 0) #=> 6

```

Streams & Enums
_____

Streams are away of doing lazy computations over container data structures
that get evaluated when parsed to an Enum function eg

```
iex> stream = Stream.cycle([1, 2, 3])
#Function<15.16982430/2 in Stream.unfold/2>
iex> Enum.take(stream, 10)
[1, 2, 3, 1, 2, 3, 1, 2, 3, 1]
```

Another interesting function is Stream.resource/3 which can be used to wrap around resources, guaranteeing they are opened right before enumeration and closed afterwards, even in the case of failures. For example, we can use it to stream a file:

eg

```
iex> stream = File.stream!("path/to/file")
#Function<18.16982430/2 in Stream.resource/3>
iex> Enum.take(stream, 10)

```

Processes
_____


In Elixir, all code runs inside processes. Processes are isolated from each other, run concurrent to one another and communicate via message passing.
Processes are not only the basis for concurrency in Elixir, but they also provide the means for building distributed and fault-tolerant programs.

send and receive
___

```
iex> send self(), {:hello, "world"}
{:hello, "world"}
iex> receive do
...>   {:hello, msg} -> msg
...>   {:world, msg} -> "won't match"
...> end
"world"

```

If we want the failure in one process to propagate to another one, we should link them. 
This can be done with spawn_link/1:

```
iex> self()
#PID<0.41.0>
iex> spawn_link fn -> raise "oops" end

** (EXIT from #PID<0.41.0>) evaluator process exited with reason: an exception was raised:
    ** (RuntimeError) oops
        (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6

[error] Process #PID<0.289.0> raised an exception
** (RuntimeError) oops
    (stdlib) erl_eval.erl:668: :erl_eval.do_apply/6

```

We often link our processes to supervisors which will detect when a process dies and start a new process in its place.

While other languages would require us to catch/handle exceptions, in Elixir we are actually fine with letting processes fail because we expect supervisors to properly restart our systems. “Failing fast” is a common philosophy when writing Elixir software!

Tasks
____

Tasks build on top of the spawn functions to provide better error reports and introspection:

Instead of spawn/1 and spawn_link/1, we use Task.start/1 and Task.start_link/1 which return {:ok, pid} rather than just the PID. This is what enables tasks to be used in supervision trees. Furthermore, Task provides convenience functions, like Task.async/1 and Task.await/1, and functionality to ease distribution.


State
_____

Processes can be used to maintain state with in application through using their PIDs as addresses.

```
iex> Process.register(pid, :kv)
true
iex> send :kv, {:get, :hello, self()}
{:get, :hello, #PID<0.41.0>}
iex> flush()
:world
:ok
```

Elix provides agents which are an abstraction around state

```
iex> {:ok, pid} = Agent.start_link(fn -> %{} end) # start agent with empty map
{:ok, #PID<0.72.0>}
iex> Agent.update(pid, fn map -> Map.put(map, :hello, :world) end) # add value to empty map
:ok
iex> Agent.get(pid, fn map -> Map.get(map, :hello) end) # get value
:world
```