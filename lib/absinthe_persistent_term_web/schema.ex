defmodule AbsinthePersistentTermWeb.Schema do
  use Absinthe.Schema
  @schema_provider Absinthe.Schema.PersistentTerm

  query do
    field :hello, :string do
      resolve(& &1)
    end
  end
end
