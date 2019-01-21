# Summary Notes

IO functions come in 2 variants, i.e  File.read/1 and  File.read!/1

The versions without ! is preferred for pattern matching as it returns a tuple

```
iex> File.read "hello"
{:ok, "world"}
iex> File.read! "hello"
"world"

case File.read(file) do
  {:ok, body}      -> # do something with the `body`
  {:error, reason} -> # handle the error caused by `reason`
end

```
