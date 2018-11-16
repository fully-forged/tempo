defmodule MbrainzTest do
  use ExUnit.Case
  doctest Mbrainz

  test "greets the world" do
    assert Mbrainz.hello() == :world
  end
end
