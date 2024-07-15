defmodule AbsinthePersistentTerm.Repo do
  use Ecto.Repo,
    otp_app: :absinthe_persistent_term,
    adapter: Ecto.Adapters.Postgres
end
