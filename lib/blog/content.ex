defmodule Blog.Content do
  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Content.{Post, Category, PostCategory}

  ##
  ## POSTS
  ##
  def list_posts do
    Post
    |> Repo.all()
    |> Repo.preload(:categories)
  end

  def get_post!(id) do
    Post
    |> Repo.get!(id)
    |> Repo.preload(:categories)
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  ##
  ## CATEGORIES
  ##
  def list_categories do
    Category
    |> Repo.all()
    |> Repo.preload(:posts)
  end

  def get_category!(id) do
    Category
    |> Repo.get!(id)
    |> Repo.preload(:posts)
  end

  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def update_category(%Category{} = category, attrs) do
    category
    |> Category.changeset(attrs)
    |> Repo.update()
  end

  def delete_category(%Category{} = category) do
    Repo.delete(category)
  end

  def change_category(%Category{} = category) do
    Category.changeset(category, %{})
  end

  ##
  ## Post Categories
  ##
  def list_selection_categories() do
    Category
    |> Repo.all()
  end

  def add_category(%Post{} = post, category_id) do
    add_category(post.id, category_id)
  end

  def add_category(post_id, category_id) do
    PostCategory.changeset(%PostCategory{}, %{post_id: post_id, category_id: category_id})
    |> Repo.insert()
  end
end
