defmodule ExplugTest do
  use ExUnit.Case
  doctest Explug

  test "greets the world" do
    assert Explug.hello() == :world
  end
end
