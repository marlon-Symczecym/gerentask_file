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

  def show_all() do
    cond do
      read() |> Enum.count() == 0 -> {:error, "Nenhum tarefa foi cadastrada ainda!"}
      read() |> Enum.count() > 0 -> read()
    end
  end

  def show_id(id), do: read() |> Enum.find(&(&1.id == id))

  def show_concluded() do
    task = read() |> Enum.find(&(&1.concluded == true))

    cond do
      task == nil ->
        {:error, "Nenhum tarefa foi concluida ainda!"}

      task != nil ->
        task
    end
  end

  def delete_id(id) do
    [show_id(id)]
    |> delete_item()
    |> :erlang.term_to_binary()
    |> write()
  end

  defp delete_item(tasks) do
    tasks
    |> Enum.reduce(read(), fn x, acc -> List.delete(acc, x) end)
  end

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
