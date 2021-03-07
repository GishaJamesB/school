defmodule School.Utils.Errors do
  import Ecto.Changeset

  def msg_func({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  def get_formatted_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      msg_func({msg, opts})
    end)
    |> Enum.reduce("", fn {k, v}, acc ->
      joined_errors = Enum.join(v, "; ")
      "#{acc}#{k}: #{joined_errors}"
    end)
  end

end
