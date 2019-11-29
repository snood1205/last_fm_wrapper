defmodule LastFmWrapper.Printer do
  alias LastFmWrapper.Configuration

  @spec print(any, Configuration.t()) :: map
  def print(printable, %Configuration{print: true}) do
    printable
    |> IO.inspect()
  end

  def print(printable, _) do
    printable
  end
end
