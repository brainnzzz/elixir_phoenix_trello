defmodule Trello.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Trello.User


  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :string
    field :first_name, :string
    field :last_name, :string

    timestamps()
  end

  @required_fields ~w(first_name last_name email password)
  @optional_fields ~w(encrypted_password)

  @derive {Poison.Encoder, only: [:id, :first_name, :last_name, :email]}

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    # |> cast(attrs, [:first_name, :last_name, :email, :encrypted_password])
    # |> validate_required([:first_name, :last_name, :email, :encrypted_password])
    |> cast(params, @required_fields, @optional_fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email, message: "Email already taken")
    |> generate_encrypted_password
  end

#private functions
  defp generate_encrypted_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(current_changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        current_changeset
    end
  end
end
