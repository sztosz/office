defmodule OfficeWeb.ErrorHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML

  @doc """
  Generates tag for inlined form input errors.
  """
  def error_tag(form, field) do
    if error = form.errors[field] do
      content_tag :span, translate_error(error), class: "help-block"
    end
  end

  @doc """
  Translates an error message using gettext.
  """
  def translate_error({msg, opts}) do
    # Because error messages were defined within Ecto, we must
    # call the Gettext module passing our Gettext backend. We
    # also use the "errors" domain as translations are placed
    # in the errors.po file.
    # Ecto will pass the :count keyword if the error message is
    # meant to be pluralized.
    # On your own code and templates, depending on whether you
    # need the message to be pluralized or not, this could be
    # written simply as:
    #
    #     dngettext "errors", "1 file", "%{count} files", count
    #     dgettext "errors", "is invalid"
    #
    if count = opts[:count] do
      Gettext.dngettext(OfficeWeb.Gettext, "errors", msg, msg, count, opts)
    else
      Gettext.dgettext(OfficeWeb.Gettext, "errors", msg, opts)
    end
  end

  def flash_errors(errors) do
    Enum.reduce(errors, "", &flash_error(&1, &2))
  end

  defp flash_error({key, msg}, output) do
    output
    <> Phoenix.Naming.humanize(key)
    <> " "
    <> OfficeWeb.ErrorHelpers.translate_error(msg)
    <> "\n"
  end
end
