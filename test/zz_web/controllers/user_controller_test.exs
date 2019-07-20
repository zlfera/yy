defmodule ZzWeb.UserControllerTest do
  use ZzWeb.ConnCase

  alias Zz.Accounts

  @create_attrs %{address: "some address", arti_person: "some arti_person", arti_phone: "some arti_phone", bank_id: "some bank_id", busi_name: "some busi_name", busi_type: "some busi_type", cert_code: "some cert_code", cust_id: "some cust_id", deposit_bank: "some deposit_bank", email: "some email", fax: "some fax", link_mane: "some link_mane", link_phone: "some link_phone", manage_type: "some manage_type", phone: "some phone"}
  @update_attrs %{address: "some updated address", arti_person: "some updated arti_person", arti_phone: "some updated arti_phone", bank_id: "some updated bank_id", busi_name: "some updated busi_name", busi_type: "some updated busi_type", cert_code: "some updated cert_code", cust_id: "some updated cust_id", deposit_bank: "some updated deposit_bank", email: "some updated email", fax: "some updated fax", link_mane: "some updated link_mane", link_phone: "some updated link_phone", manage_type: "some updated manage_type", phone: "some updated phone"}
  @invalid_attrs %{address: nil, arti_person: nil, arti_phone: nil, bank_id: nil, busi_name: nil, busi_type: nil, cert_code: nil, cust_id: nil, deposit_bank: nil, email: nil, fax: nil, link_mane: nil, link_phone: nil, manage_type: nil, phone: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :new))
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.user_path(conn, :show, id)

      conn = get(conn, Routes.user_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    setup [:create_user]

    test "renders form for editing chosen user", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_path(conn, :edit, user))
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    setup [:create_user]

    test "redirects when data is valid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert redirected_to(conn) == Routes.user_path(conn, :show, user)

      conn = get(conn, Routes.user_path(conn, :show, user))
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert redirected_to(conn) == Routes.user_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
