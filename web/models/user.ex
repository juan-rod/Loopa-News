defmodule Microscope.User do
  use Microscope.Web, :model

  @derive {Poison.Encoder, only: [:id, :username]}

  schema "users" do
    field :username , :string
    field :password , :string, virtual: true
    field :encrypted_password, :string

    timestamps()
  end

  @fields [:username, :password]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:username, min: 5)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:username, message: "Username already taken")
    |> generate_encrypted_password
  end

  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end
