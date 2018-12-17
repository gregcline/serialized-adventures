defmodule SerializedAdventures.Repo do
  use Ecto.Repo,
    otp_app: :serialized_adventures,
    adapter: Ecto.Adapters.Postgres
end
