defmodule Shoja.OrganizationsTest do
  use Shoja.DataCase

  alias Shoja.Organizations

  describe "organizations" do
    alias Shoja.Organizations.Organization

    import Shoja.OrganizationsFixtures

    @invalid_attrs %{name: nil, domain: nil, description: nil, unique_name: nil, logo: nil, is_private: nil}

    test "list_organizations/0 returns all organizations" do
      organization = organization_fixture()
      assert Organizations.list_organizations() == [organization]
    end

    test "get_organization!/1 returns the organization with given id" do
      organization = organization_fixture()
      assert Organizations.get_organization!(organization.id) == organization
    end

    test "create_organization/1 with valid data creates a organization" do
      valid_attrs = %{name: "some name", domain: "some domain", description: "some description", unique_name: "some unique_name", logo: "some logo", is_private: true}

      assert {:ok, %Organization{} = organization} = Organizations.create_organization(valid_attrs)
      assert organization.name == "some name"
      assert organization.domain == "some domain"
      assert organization.description == "some description"
      assert organization.unique_name == "some unique_name"
      assert organization.logo == "some logo"
      assert organization.is_private == true
    end

    test "create_organization/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Organizations.create_organization(@invalid_attrs)
    end

    test "update_organization/2 with valid data updates the organization" do
      organization = organization_fixture()
      update_attrs = %{name: "some updated name", domain: "some updated domain", description: "some updated description", unique_name: "some updated unique_name", logo: "some updated logo", is_private: false}

      assert {:ok, %Organization{} = organization} = Organizations.update_organization(organization, update_attrs)
      assert organization.name == "some updated name"
      assert organization.domain == "some updated domain"
      assert organization.description == "some updated description"
      assert organization.unique_name == "some updated unique_name"
      assert organization.logo == "some updated logo"
      assert organization.is_private == false
    end

    test "update_organization/2 with invalid data returns error changeset" do
      organization = organization_fixture()
      assert {:error, %Ecto.Changeset{}} = Organizations.update_organization(organization, @invalid_attrs)
      assert organization == Organizations.get_organization!(organization.id)
    end

    test "delete_organization/1 deletes the organization" do
      organization = organization_fixture()
      assert {:ok, %Organization{}} = Organizations.delete_organization(organization)
      assert_raise Ecto.NoResultsError, fn -> Organizations.get_organization!(organization.id) end
    end

    test "change_organization/1 returns a organization changeset" do
      organization = organization_fixture()
      assert %Ecto.Changeset{} = Organizations.change_organization(organization)
    end
  end
end
