defmodule Poselink.GuardianSerializer do
  @behaviour Guardian.Serializer

  alias Poselink.Repo
  alias Poselink.User

  def for_token(user = %User{}), do: {:ok, "User:#{user.id}"}
  def for_token(_), do: {:error, "Unknown resource type"}

  def from_token("User:" <> id), do: {:ok, Repo.get(User, String.to_integer(id))}
  def from_token(_), do: {:error, "Unknown resource type"}

  def from_access_token(jwt) do
    case Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        from_token(claims["sub"])
      error ->
        error
    end
  end
end
