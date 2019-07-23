defmodule Zz.Repo.Migrations.DropUniqLinkPhone do
  use Ecto.Migration

  def change do
    drop unique_index(:users, [:arti_phone])
  end
end
