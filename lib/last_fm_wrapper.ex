defmodule LastFmWrapper do
  defdelegate run(), to: LastFmWrapper.Runner
end
