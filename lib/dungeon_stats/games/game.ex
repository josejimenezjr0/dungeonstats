defmodule DungeonStats.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field(:name, :string)
    field(:slug, :string)
    field(:started_at, :utc_datetime)
    field(:ended_at, :utc_datetime)
    field(:last_move_at, :utc_datetime)

    timestamps()
  end

  @spec changeset(
          {map, map}
          | %{
              :__struct__ => atom | %{:__changeset__ => map, optional(any) => any},
              optional(atom) => any
            },
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:name, :started_at, :ended_at, :last_move_at])
    |> validate_required([:name])
    |> validate_length(:name, min: 5, max: 128)
    |> slugify_name()
    |> validate_format(:slug, ~r/[a-z0-9]+[a-z0-9_]*/)
    |> validate_length(:slug,
      min: 5,
      message: "Unable to make a link with this name. Try removing non-alphanumeric characters"
    )
    |> unique_constraint(:slug)
  end

  defp slugify_name(%Ecto.Changeset{changes: %{slug: slug}} = changeset) when slug != nil,
    do: changeset

  defp slugify_name(%Ecto.Changeset{valid?: true, changes: %{name: name}} = changeset) do
    slug = slugify(name)

    changeset
    |> change(slug: slug)
  end

  defp slugify_name(changeset), do: changeset

  @doc """
  Try to make a URL friendly version of a string.  Result should be all lower case alphanumeric plus `_`
  """
  def slugify(string) do
    string
    |> String.replace(" ", "_")
    |> Macro.underscore()
    |> String.replace(~r/[^a-z0-9_]/, "_")
    |> String.replace(~r/_{2,}/, "_")
    |> String.trim("_")
  end
end
