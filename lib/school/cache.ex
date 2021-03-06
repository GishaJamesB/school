defmodule School.Cache do
  use GenServer

  @name __MODULE__

  def start_link(_), do: GenServer.start_link(__MODULE__, [], name: @name)

  @impl true
  def init(_) do
    IO.puts("Creating ETS #{@name}")
    :ets.new(:school_bucket, [:set, :public, :named_table])
    {:ok, "ETS Created"}
  end

  def add(key) do
    GenServer.call(@name, {:insert, key})
  end

  def get(key) do
    GenServer.call(@name, {:get, key})
  end

  def remove(key) do
    GenServer.call(@name, {:delete, key})
  end

  @impl true
  def handle_call({:insert, key}, _ref, state) do
    :ets.insert_new(:school_bucket, key)
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:delete, key}, _ref, state) do
    :ets.delete(:school_bucket, key)
    {:reply, :ok, state}
  end

  @impl true
  def handle_call({:get, key}, _ref, state) do
    result = :ets.lookup(:school_bucket, key)
    {:reply, result, state}
  end
end
