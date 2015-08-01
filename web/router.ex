defmodule Apiv2.Router do
  use Apiv2.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Apiv2 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/print", Apiv2 do
    pipe_through :browser # Use the default browser stack
    get "/reports", ReportController, :index
  end

  scope "/apiv2", Apiv2 do
    pipe_through :api
    resources "/cameras", CameraController, except: [:edit, :new]
    resources "/tiles", TileController, except: [:edit, :new]
    resources "/appointments", AppointmentController, except: [:edit, :new]
    resources "/trucks", TruckController, except: [:edit, :new]
    resources "/weightickets", WeighticketController, except: [:edit, :new]
    resources "/batches", BatchController, except: [:edit, :new]
    resources "/employees", EmployeeController, except: [:edit, :new]
    resources "/batch_relationships", BatchRelationshipController, except: [:edit, :new]
    resources "/appointment_relationships", AppointmentRelationshipController, except: [:edit, :new]
    resources "/pictures", PictureController, except: [:edit, :new, :show, :index]
    resources "/accounts", AccountController, only: [:show]
  end
end
