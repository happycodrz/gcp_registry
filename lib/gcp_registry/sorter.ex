defmodule GcpRegistry.Sorter do
  # https://github.com/RaymondLoranger/map_sorter
  def sort(items, key) do
    items
    |> Enum.sort_by(
      fn item ->
        v = item |> Map.get(key)
        comparable(v)
      end,
      &>=/2
    )
  end

  def comparable(%Date{} = value), do: Date.to_string(value)
  def comparable(%DateTime{} = value), do: DateTime.to_string(value)
  def comparable(%NaiveDateTime{} = value), do: NaiveDateTime.to_string(value)
  def comparable(%Time{} = value), do: Time.to_string(value)
  def comparable(%Version{} = value), do: to_string(value)
  def comparable(%Regex{} = value), do: Regex.source(value)
  def comparable(value = value), do: value
end
