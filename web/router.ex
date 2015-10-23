defmodule HelloPhoenix.Router do
  use HelloPhoenix.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", HelloPhoenix do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show

    # NOTE: UserController and PostController do not exist. Used here only to show example of nesting.
    resources "users", UserController do
      resources "posts", PostController
     end

     # NOTE: more dummy controllers
     resources "reviews", ReviewController
     resources "/images", ImageController
  end

  # NOTE: no controllers within this scope exist. Used here only to show examples of scoped routes.
  # as: :admin will differentiate this path helper from standard review path helper by adding admin_ to beginning
  scope "/admin", HelloPhoenix.Admin, as: :admin do
    pipe_through :browser

    resources "/images", ImageController
    resources "/reviews", ReviewController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloPhoenix do
  #   pipe_through :api
  # end
end
