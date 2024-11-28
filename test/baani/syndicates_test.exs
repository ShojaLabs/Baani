defmodule Baani.SyndicatesTest do
  use Baani.DataCase

  alias Baani.Syndicates

  describe "syndicates" do
    alias Baani.Syndicates.Syndicate

    import Baani.SyndicatesFixtures

    @invalid_attrs %{title: nil, unique_identifier: nil}

    test "list_syndicates/0 returns all syndicates" do
      syndicate = syndicate_fixture()
      assert Syndicates.list_syndicates() == [syndicate]
    end

    test "get_syndicate!/1 returns the syndicate with given id" do
      syndicate = syndicate_fixture()
      assert Syndicates.get_syndicate!(syndicate.id) == syndicate
    end

    test "create_syndicate/1 with valid data creates a syndicate" do
      valid_attrs = %{title: "some title", unique_identifier: "some unique_identifier"}

      assert {:ok, %Syndicate{} = syndicate} = Syndicates.create_syndicate(valid_attrs)
      assert syndicate.title == "some title"
      assert syndicate.unique_identifier == "some unique_identifier"
    end

    test "create_syndicate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Syndicates.create_syndicate(@invalid_attrs)
    end

    test "update_syndicate/2 with valid data updates the syndicate" do
      syndicate = syndicate_fixture()
      update_attrs = %{title: "some updated title", unique_identifier: "some updated unique_identifier"}

      assert {:ok, %Syndicate{} = syndicate} = Syndicates.update_syndicate(syndicate, update_attrs)
      assert syndicate.title == "some updated title"
      assert syndicate.unique_identifier == "some updated unique_identifier"
    end

    test "update_syndicate/2 with invalid data returns error changeset" do
      syndicate = syndicate_fixture()
      assert {:error, %Ecto.Changeset{}} = Syndicates.update_syndicate(syndicate, @invalid_attrs)
      assert syndicate == Syndicates.get_syndicate!(syndicate.id)
    end

    test "delete_syndicate/1 deletes the syndicate" do
      syndicate = syndicate_fixture()
      assert {:ok, %Syndicate{}} = Syndicates.delete_syndicate(syndicate)
      assert_raise Ecto.NoResultsError, fn -> Syndicates.get_syndicate!(syndicate.id) end
    end

    test "change_syndicate/1 returns a syndicate changeset" do
      syndicate = syndicate_fixture()
      assert %Ecto.Changeset{} = Syndicates.change_syndicate(syndicate)
    end
  end
end
