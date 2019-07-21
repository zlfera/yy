defmodule Zz.Repo.Migrations.AddUniqArtiPhone do
  use Ecto.Migration

  def change do
    create unique_index(:users, [:arti_phone])
  end
end
