defmodule SchoolWeb.ChildrenController do
  use SchoolWeb, :controller

  def index(conn, _params) do
    data = School.Services.Children.get_all
    render conn, "children.json", children: data
  end
end