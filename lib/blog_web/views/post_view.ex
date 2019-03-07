defmodule BlogWeb.PostView do
  use BlogWeb, :view

  def markdown(content) do
    content
    |> Earmark.as_html!()
    |> raw()
  end

  def display_date(datetime) do
    datetime
    |> DateTime.to_date()
    |> Date.to_string()
  end
end
