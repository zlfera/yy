defmodule Zz.AccountsTest do
  use Zz.DataCase

  alias Zz.Accounts

  describe "users" do
    alias Zz.Accounts.User

    @valid_attrs %{address: "some address", arti_person: "some arti_person", arti_phone: "some arti_phone", bank_id: "some bank_id", busi_name: "some busi_name", busi_type: "some busi_type", cert_code: "some cert_code", cust_id: "some cust_id", deposit_bank: "some deposit_bank", email: "some email", fax: "some fax", link_mane: "some link_mane", link_phone: "some link_phone", manage_type: "some manage_type", phone: "some phone"}
    @update_attrs %{address: "some updated address", arti_person: "some updated arti_person", arti_phone: "some updated arti_phone", bank_id: "some updated bank_id", busi_name: "some updated busi_name", busi_type: "some updated busi_type", cert_code: "some updated cert_code", cust_id: "some updated cust_id", deposit_bank: "some updated deposit_bank", email: "some updated email", fax: "some updated fax", link_mane: "some updated link_mane", link_phone: "some updated link_phone", manage_type: "some updated manage_type", phone: "some updated phone"}
    @invalid_attrs %{address: nil, arti_person: nil, arti_phone: nil, bank_id: nil, busi_name: nil, busi_type: nil, cert_code: nil, cust_id: nil, deposit_bank: nil, email: nil, fax: nil, link_mane: nil, link_phone: nil, manage_type: nil, phone: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.address == "some address"
      assert user.arti_person == "some arti_person"
      assert user.arti_phone == "some arti_phone"
      assert user.bank_id == "some bank_id"
      assert user.busi_name == "some busi_name"
      assert user.busi_type == "some busi_type"
      assert user.cert_code == "some cert_code"
      assert user.cust_id == "some cust_id"
      assert user.deposit_bank == "some deposit_bank"
      assert user.email == "some email"
      assert user.fax == "some fax"
      assert user.link_mane == "some link_mane"
      assert user.link_phone == "some link_phone"
      assert user.manage_type == "some manage_type"
      assert user.phone == "some phone"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.address == "some updated address"
      assert user.arti_person == "some updated arti_person"
      assert user.arti_phone == "some updated arti_phone"
      assert user.bank_id == "some updated bank_id"
      assert user.busi_name == "some updated busi_name"
      assert user.busi_type == "some updated busi_type"
      assert user.cert_code == "some updated cert_code"
      assert user.cust_id == "some updated cust_id"
      assert user.deposit_bank == "some updated deposit_bank"
      assert user.email == "some updated email"
      assert user.fax == "some updated fax"
      assert user.link_mane == "some updated link_mane"
      assert user.link_phone == "some updated link_phone"
      assert user.manage_type == "some updated manage_type"
      assert user.phone == "some updated phone"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
