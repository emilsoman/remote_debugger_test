defmodule RemoteDebuggerTest do
  use GenServer

  @timer 3000

  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    set_timer()
    {:ok, nil}
  end

  def handle_info(:trigger, state) do
    IO.inspect "Received trigger"
    set_timer()
    {:noreply, state}
  end

  defp set_timer do
    Process.send_after(self(), :trigger, @timer)
  end
end
