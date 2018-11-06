defmodule Zz.Repo do
  use Ecto.Repo,
    otp_app: :zz,
    adapter: Ecto.Adapters.Postgres
end
