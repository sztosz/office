%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "src/", "web/", "apps/"],
        excluded: []
      },
      checks: [
        {Credo.Check.Consistency.TabsOrSpaces},
        {Credo.Check.Design.AliasUsage, priority: :high},
        {Credo.Check.Readability.MaxLineLength, priority: :medium, max_length: 120},
        {Credo.Check.Design.TagTODO, exit_status: 2},
        {Credo.Check.Design.TagFIXME, false},
        {Credo.Check.Readability.ModuleDoc, false},
      ]
    }
  ]
}
