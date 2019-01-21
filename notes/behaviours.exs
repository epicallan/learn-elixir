# Behaviours are similar to interfaces
# read https://www.djm.org.uk/posts/elixir-behaviours-vs-protocols-what-is-the-difference/

defmodule Parser do
  @callback parse(String.t) :: {:ok, term} | {:error, String.t}
  @callback extensions() :: [String.t]
  # with dynamic dispatching
  def parse!(implementation, contents) do
    case implementation.parse(contents) do
      {:ok, data} -> data
      {:error, error} -> raise ArgumentError, "parsing error: #{error}"
    end
  end
end
defmodule JSONParser do
  @behaviour Parser

  def parse(str), do: {:ok, "some json " <> str} # ... parse JSON
  def extensions, do: ["json"]
end


defmodule YAMLParser do
  @behaviour Parser

  def parse(str), do: {:ok, "some yaml " <> str} # ... parse YAML
  def extensions, do: ["yml"]
end






