defmodule Baani.SyndicatesTest do
  use Baani.DataCase

  alias Baani.Syndicates

  describe "syndicates" do
    alias Baani.Syndicates.Syndicate

    import Baani.SyndicatesFixtures

    @invalid_attrs %{
      description: nil,
      title: nil,
      unique_identifier: nil,
      bio: nil,
      website: nil,
      logo_url: nil,
      banner_url: nil,
      twitter_url: nil,
      facebook_url: nil,
      instagram_url: nil,
      linkedin_url: nil,
      youtube_url: nil,
      github_url: nil
    }

    test "list_syndicates/0 returns all syndicates" do
      syndicate = syndicate_fixture()
      assert Syndicates.list_syndicates() == [syndicate]
    end

    test "get_syndicate!/1 returns the syndicate with given id" do
      syndicate = syndicate_fixture()
      assert Syndicates.get_syndicate!(syndicate.id) == syndicate
    end

    test "create_syndicate/1 with valid data creates a syndicate" do
      valid_attrs = %{
        description: "some description",
        title: "some title",
        unique_identifier: "some unique_identifier",
        bio: "some bio",
        website: "some website",
        logo_url: "some logo_url",
        banner_url: "some banner_url",
        twitter_url: "some twitter_url",
        facebook_url: "some facebook_url",
        instagram_url: "some instagram_url",
        linkedin_url: "some linkedin_url",
        youtube_url: "some youtube_url",
        github_url: "some github_url"
      }

      assert {:ok, %Syndicate{} = syndicate} = Syndicates.create_syndicate(valid_attrs)
      assert syndicate.description == "some description"
      assert syndicate.title == "some title"
      assert syndicate.unique_identifier == "some unique_identifier"
      assert syndicate.bio == "some bio"
      assert syndicate.website == "some website"
      assert syndicate.logo_url == "some logo_url"
      assert syndicate.banner_url == "some banner_url"
      assert syndicate.twitter_url == "some twitter_url"
      assert syndicate.facebook_url == "some facebook_url"
      assert syndicate.instagram_url == "some instagram_url"
      assert syndicate.linkedin_url == "some linkedin_url"
      assert syndicate.youtube_url == "some youtube_url"
      assert syndicate.github_url == "some github_url"
    end

    test "create_syndicate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Syndicates.create_syndicate(@invalid_attrs)
    end

    test "update_syndicate/2 with valid data updates the syndicate" do
      syndicate = syndicate_fixture()

      update_attrs = %{
        description: "some updated description",
        title: "some updated title",
        unique_identifier: "some updated unique_identifier",
        bio: "some updated bio",
        website: "some updated website",
        logo_url: "some updated logo_url",
        banner_url: "some updated banner_url",
        twitter_url: "some updated twitter_url",
        facebook_url: "some updated facebook_url",
        instagram_url: "some updated instagram_url",
        linkedin_url: "some updated linkedin_url",
        youtube_url: "some updated youtube_url",
        github_url: "some updated github_url"
      }

      assert {:ok, %Syndicate{} = syndicate} =
               Syndicates.update_syndicate(syndicate, update_attrs)

      assert syndicate.description == "some updated description"
      assert syndicate.title == "some updated title"
      assert syndicate.unique_identifier == "some updated unique_identifier"
      assert syndicate.bio == "some updated bio"
      assert syndicate.website == "some updated website"
      assert syndicate.logo_url == "some updated logo_url"
      assert syndicate.banner_url == "some updated banner_url"
      assert syndicate.twitter_url == "some updated twitter_url"
      assert syndicate.facebook_url == "some updated facebook_url"
      assert syndicate.instagram_url == "some updated instagram_url"
      assert syndicate.linkedin_url == "some updated linkedin_url"
      assert syndicate.youtube_url == "some updated youtube_url"
      assert syndicate.github_url == "some updated github_url"
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
