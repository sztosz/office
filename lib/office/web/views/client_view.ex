defmodule Office.Web.ClientView do
  use Office.Web, :view
  import IEx

  alias Office.Litigation.Schemas.Phone
  alias Office.Litigation.Schemas.Email

  def with_empty_phones_and_emails(client) do
    # IEx.pry
    client
    |> fill_to_three(%Phone{})
    |> fill_to_three(%Email{})

    # change(
    #   %Client{
    #     phones: [%Phone{}, %Phone{}, %Phone{}],
    #     emails: [%Email{}, %Email{}, %Email{}]
    #   }
    # )
    # TODO: Move inserting empty emails and phones to view
  end

  # TODO: GET RID OF MAGIC NUMBERS AND MAYBE BETTER NAMING

  def fill_to_three(map, struct) do
    key = key_from_struct(struct)
    changes = case Map.get(map, key) do
      nil -> add_structs(map, key, struct, 3)
      list when is_list(list) -> add_structs(map, key, struct, 3 - Enum.count(list))
    end
    %{map | changes: changes}
  end

  def key_from_struct(struct) do
    # IEx.pry
    name = struct.__struct__
      |> Atom.to_string 
      |> String.split(".") 
      |> List.last 
      |> String.downcase
    name <> "s" |> String.to_atom
  end
  
  def add_structs(map, key, struct, count) when count == 3 do
    empty_structs = preapare_structs_list(struct, count)
    changes = map |> Map.get(:changes) |> Map.put(key, empty_structs)

  end

  def add_structs(map, key, struct, count) when count == 2 or count == 1 do
    changes = Map.get{map, :changes}
    empty_structs = Map.get(changes, key) ++ preapare_structs_list(struct, count) 
    changes = Map.put(changes, key, empty_structs)
    
  end

  def add_structs(map, _, _, count) when count == 0, do: map |> Map.get(:changes)

  def preapare_structs_list(struct, count) do
    structs = []
    for i <- 1..count do
      structs ++ struct
    end
  end
end
