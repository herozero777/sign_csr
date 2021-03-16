defmodule SignCsr.Repo do
  use Ecto.Repo,
    otp_app: :sign_csr,
    adapter: Ecto.Adapters.Postgres
end
