defmodule Apiv2.Batch do
  use Apiv2.Web, :model
  @batch_types ~w(incoming outgoing split)

  schema "apiv2_batches" do
    field :outgoing_count, :integer, default: 0
    field :permalink, :string
    field :description, :string
    field :quantity, :string
    field :deleted_at, Ecto.DateTime
    belongs_to :dock, Apiv2.Tile, foreign_key: :dock_id
    belongs_to :warehouse, Apiv2.Tile, foreign_key: :warehouse_id
    belongs_to :appointment, Apiv2.Appointment, foreign_key: :appointment_id
    belongs_to :truck, Apiv2.Truck, foreign_key: :truck_id
    has_many :relationships, Apiv2.BatchRelationship, foreign_key: :batch_id
    has_many :pickup_appointments, through: [:relationships, :appointment]
    has_many :pictures, {"apiv2_batch_pictures", Apiv2.Picture}, foreign_key: :assoc_id
    timestamps 
  end

  @required_fields ~w(warehouse_id outgoing_count)
  @optional_fields ~w(dock_id appointment_id description permalink quantity truck_id deleted_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_inclusion(:batch_type, @batch_types)
  end

  before_insert :create_permalink
  def create_permalink(changeset) do
    permalink = changeset |> Ecto.Changeset.get_field(:permalink)
    appointment_id = changeset |> Ecto.Changeset.get_field(:appointment_id)
    v = :random.uniform(1000000)
    changeset
    |> Ecto.Changeset.put_change(:permalink, "#{v}-#{permalink || appointment_id}")
  end
end
