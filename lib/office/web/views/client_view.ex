defmodule Office.Web.ClientView do
  use Office.Web, :view

  alias Office.Litigation.Schemas.Phone
  alias Office.Litigation.Schemas.Email
  alias Office.Litigation.Schemas.Client

  def with_empty_embeds(client) do
    changes = client
    |> Map.get(:changes)
    |> Map.put(:phones, [%Phone{}, %Phone{}, %Phone{}])
    |> Map.put(:emails, [%Email{}, %Email{}, %Email{}])
    %{client | changes: changes}
  end

#  def with_empty_phones_and_emails(client) do
#    client
#    |> fill_empty_embed(%Phone{}, Client.embeded_count)
#    |> fill_empty_embed(%Email{}, Client.embeded_count)
#  end
#
#  def fill_empty_embed(map, struct, count) do
#    key = key_from_struct(struct)
#    changes = case Map.get(map, key) do
#      nil -> add_structs(map, key, struct, 3)
#      list when is_list(list) -> add_structs(map, key, struct, count - Enum.count(list))
#    end
#    %{map | changes: changes}
#  end
#
#  def key_from_struct(struct) do
#    name = struct.__struct__
#      |> Atom.to_string
#      |> String.split(".")
#      |> List.last
#      |> String.downcase
#    name <> "s" |> String.to_atom
#  end
#
#  def add_structs(map, key, struct, count) when count == 3 do
#    empty_structs = preapare_structs_list(struct, count)
#    changes = map |> Map.get(:changes) |> Map.put(key, empty_structs)
#  end
#
#  def add_structs(map, key, struct, count) when count == 2 or count == 1 do
#    changes = Map.get{map, :changes}
#    empty_structs = Map.get(changes, key) ++ preapare_structs_list(struct, count)
#    changes = Map.put(changes, key, empty_structs)
#  end
#
#  def add_structs(map, _, _, count) when count == 0, do: map |> Map.get(:changes)
#
#  def preapare_structs_list(struct, count) do
#    structs = []
#    for i <- 1..count do
#      structs ++ struct
#    end
#  end
end
