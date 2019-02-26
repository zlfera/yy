defmodule ZzWeb.GrainView do
  use ZzWeb, :view

  def dizeng(pid) do
    Agent.update(pid, fn i -> i + 1 end)
    Agent.get(pid, fn i -> i end)
  end
end
