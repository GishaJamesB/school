defmodule School.Cache do
  use GenServer

  @name __MODULE__

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

  def init(_) do
    IO.puts("Creating ETS #{@name}")
    :ets.new(:school_bucket, [:set, :named_table])
    {:ok, "ETS Created"}
  end

  def get(data) do
    GenServer.call(@name, {:get, data})
  end

  def remove(:children) do
    GenServer.call(@name, {:delete, :children})
  end

  def handle_call({:insert, data}, _ref, state) do
    :ets.insert(:school_bucket, data)
    {:reply, :ok, state}
  end

  def handle_call({:delete, :children}, _ref, state) do
    :ets.delete(:school_bucket, :children)
    {:reply, :ok, state}
  end

  def handle_call({:get, data}, _ref, state) do
    :ets.lookup(:school_bucket, data)
    {:reply, :ok, state}
  end

  def create_ets_bucket() do
    :ets.new(:school_bucket, [:set, :protected, :named_table])
  end
end
