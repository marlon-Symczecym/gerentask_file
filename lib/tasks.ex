defmodule Tasks do
  @moduledoc """
  Module onde tera toda estrutura das tarefas
  """
  @tasks %{:directory => "files", :file => "tasks.txt"}

  defp write() do
  end

  def read() do
    {:ok, file} = File.read("#{@tasks[:directory]}/#{@tasks[:file]}")

    file
    |> :erlang.binary_to_term()
  end
end
