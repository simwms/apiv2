defmodule Apiv2.Arrow do
  def compose(f1, f2) do
    fn x ->
      x |> f1.() |> f2.()
    end
  end
end