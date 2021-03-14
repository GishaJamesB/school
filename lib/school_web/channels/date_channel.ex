defmodule SchoolWeb.DateChannel do
  use Phoenix.Channel

  def join("dates", _message, socket) do
    {:ok, socket}
  end

  def handle_in("new_msg", %{"date" => date}, socket) do
    broadcast!(socket, "new_msg", %{date: date})
    {:noreply, socket}
  end

end
