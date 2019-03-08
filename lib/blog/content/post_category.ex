defmodule Blog.Content.PostCategory do
  use Ecto.Schema
  import Ecto.Changeset
  alias Blog.Content.{Category, Post}

  schema "post_categories" do
    belongs_to :post, Post
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(post_category, attrs) do
    post_category
    |> cast(attrs, [:post_id, :category_id])
    |> validate_required([])
  end
end
