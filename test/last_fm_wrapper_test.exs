defmodule LastFmWrapperTest do
  use ExUnit.Case
  doctest LastFmWrapper

  test "greets the world" do
    assert LastFmWrapper.hello() == :world
  end
end
