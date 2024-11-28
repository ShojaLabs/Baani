defmodule Baani.SyndicatesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Baani.Syndicates` context.
  """

  @doc """
  Generate a syndicate.
  """
  def syndicate_fixture(attrs \\ %{}) do
    {:ok, syndicate} =
      attrs
      |> Enum.into(%{
        banner_url: "some banner_url",
        bio: "some bio",
        description: "some description",
        facebook_url: "some facebook_url",
        github_url: "some github_url",
        instagram_url: "some instagram_url",
        linkedin_url: "some linkedin_url",
        logo_url: "some logo_url",
        title: "some title",
        twitter_url: "some twitter_url",
        unique_identifier: "some unique_identifier",
        website: "some website",
        youtube_url: "some youtube_url"
      })
      |> Baani.Syndicates.create_syndicate()

    syndicate
  end
end
