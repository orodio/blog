defmodule BlogWeb.CategoryView do
  use BlogWeb, :view

  def display_date(datetime) do
    datetime
    |> DateTime.to_date()
    |> Date.to_string()
  end
end
