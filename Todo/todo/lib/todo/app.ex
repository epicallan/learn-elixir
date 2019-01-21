defmodule Todo.App do
  use GenServer

  ## Client API

  @doc """
  Starts the app with the given options.

  `:name` is always required.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Ensures there is a bucket associated with the given `name` in `server`.
  """
  def createTodo(server, todoItem) do
    GenServer.call(server, {:create, todoItem})
  end

  def removeTodo(server, todoItem) do
    GenServer.call(server, {:remove, todoItem})
  end

  def stop(server) do
    GenServer.stop(server)
  end

  ## Server callbacks

  def init(:ok) do
    todoList = []
    {:ok, todoList}
  end

  # 4. The previous hxzandle_call callback for lookup was removed

  def handle_call(action, _from, todoList) do
    case action do
      {:create, item} ->  {:reply, [item | todoList], [item | todoList]}
      {:remove, item} ->  {:reply, List.delete(todoList, item), List.delete(todoList, item)}
      _              ->   {:reply, todoList, todoList}
    end
  end

  def handle_info(_msg, state) do
    {:noreply, state}
  end
end
