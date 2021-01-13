defmodule GerentaskFile do
  @moduledoc """
  Modulo que gerencia todas as chamadas de metodos
  """
  @tasks %{:directory => "files", :file => "tasks.txt"}
  def start do
    File.mkdir(@tasks[:directory])
    File.write("#{@tasks[:directory]}/#{@tasks[:file]}", :erlang.term_to_binary([]))
  end
end
