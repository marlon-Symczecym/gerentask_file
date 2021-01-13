defmodule Tasks do
  @moduledoc """
  Module onde tera toda estrutura das tarefas
  """
  defstruct message: nil, concluded: false, levels: nil
  @tasks %{:directory => "files", :file => "tasks.txt"}

  def create(message, levels) do
    (read() ++ [%__MODULE__{message: message, levels: levels}])
    |> :erlang.term_to_binary()
    |> write()
  end

  defp write(tasks) do
    File.write("#{@tasks[:directory]}/#{@tasks[:file]}", tasks)
  end

  def read() do
    {:ok, file} = File.read("#{@tasks[:directory]}/#{@tasks[:file]}")

    file
    |> :erlang.binary_to_term()
  end
end
