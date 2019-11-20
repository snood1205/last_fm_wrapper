defmodule LastFmWrapper do
  defdelegate run(), to: LastFmWrapper.Runner
  defdelegate run(configuration, last_time), to: LastFmWrapper.Runner
end
