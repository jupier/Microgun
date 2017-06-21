defmodule Mix.Tasks.Ciex do
  use Mix.Task
  @shortdoc "Simply compile and run ciex."
  def run(_) do
    Mix.shell.info 'Compile and run iex'
    Mix.shell.cmd "mix compile && iex -S mix"
  end
end