defmodule Poselink.Router do
  use Poselink.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource
  end

  scope "/api", Poselink do
    pipe_through :api

    get "/", PingController, :show

    post "/sessions", SessionController, :create
    delete "/sessions", SessionController, :delete
    post "/sessions/refresh", SessionController, :refresh
    get "/sessions/user", SessionController, :show_user
    resources "/users", UserController, only: [:create]
    resources "/services", ServiceController, only: [:index]
    resources "/combinations", CombinationController, except: [:show]
    resources "/user_service_configs",
      UserServiceConfigController, only: [:index, :show, :create]
    get "/user_service_configs", UserServiceConfigController, :show
    patch "/user_service_configs", UserServiceConfigController, :update
    post "/trigger/trigger", TriggerController, :trigger


    post "/line_notify/callback", LineNotifyController, :callback
  end

  scope "/webhook", Poselink do
    pipe_through :api

    get "/line/callback", LineMessagingController, :callback
    post "/line/callback", LineMessagingController, :callback
  end
end
