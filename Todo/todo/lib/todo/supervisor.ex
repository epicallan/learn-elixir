defmodule Todo.Supervisor do
  use Supervisor

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    children = [
      {Todo.App, name: Todo.App}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end

end
