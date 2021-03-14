defmodule SchoolWeb.Router do
  use SchoolWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug
  end

  scope "/api", SchoolWeb do
    pipe_through :api

    get "/children", ChildrenController, :index
    get "/children/:id", ChildrenController, :get_child
    get "/dates", DatesController, :get

    post "/date", DatesController, :create
    options "/date", DatesController, :create

    get "/attendance/:date", AttendanceController, :get_attendance_by_date
    get "/attendance-report", AttendanceController, :get_attendance

    post "/attendance", AttendanceController, :create
    options "/attendance", AttendanceController, :create
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: SchoolWeb.Telemetry
    end
  end
end
