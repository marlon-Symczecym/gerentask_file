defmodule Tasks do
  @moduledoc """
  Module onde tera toda estrutura das tarefas
  """
  defstruct id: 0, message: nil, concluded: false, levels: nil
  @tasks %{:directory => "files", :file => "tasks.txt"}

  def create(message, levels) do
    (read() ++ [%__MODULE__{id: id_generate() + 1, message: message, levels: levels}])
    |> :erlang.term_to_binary()
    |> write()
  end

  def show_all(), do: read()
  def show_id(id), do: read() |> Enum.find(&(&1.id == id))

  defp write(tasks) do
    File.write("#{@tasks[:directory]}/#{@tasks[:file]}", tasks)
  end

  defp id_generate() do
    read()
    |> Enum.count()
  end

  defp read() do
    {:ok, file} = File.read("#{@tasks[:directory]}/#{@tasks[:file]}")

    file
    |> :erlang.binary_to_term()
  end
end
