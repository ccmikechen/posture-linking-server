defmodule Poselink.PostureView do
  use Poselink.Web, :view

  def render("index.json", %{postures: postures}) do
    %{data: render_many(postures, Poselink.PostureView, "posture.json")}
  end

  def render("show.json", %{posture: posture}) do
    %{data: render_one(posture, Poselink.PostureView, "posture.json")}
  end

  def render("posture.json", %{posture: posture}) do
    %{
      id: posture.id,
      name: posture.name,
      classification: posture.classification.name,
      type: posture.type
    }
  end

  def render("dataset.json", %{dataset: {data, type}}) do
    %{
      data: data,
      type: type
    }
  end

  def render("build.json", %{graph_path: graph_path}) do
    %{
      path: graph_path
    }
  end
end
