defmodule Zz.Repo.Migrations.CreateUniqLinkPhone do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:arti_phone])
  end
end
