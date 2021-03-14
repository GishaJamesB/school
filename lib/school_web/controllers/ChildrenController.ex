defmodule SchoolWeb.ChildrenController do
  use SchoolWeb, :controller

  def index(conn, _params) do
    data = School.Services.Children.get_all
    render conn, "children.json", children: data
  end

  def get_child(conn, %{"id" => id}) do
    data = School.Services.Children.get_child(id)
    render conn, "single.json", child: data
  end
end
