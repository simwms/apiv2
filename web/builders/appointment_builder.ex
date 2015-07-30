defmodule Apiv2.AppointmentBuilder do
  alias __MODULE__
  alias Apiv2.Appointment
  alias Apiv2.Repo

  defstruct valid?: false,
    changeset: Appointment.changeset(%Appointment{}, %{}),
    partials: []

  def buildset(params) do
    initial_changeset = Appointment.changeset(%Appointment{}, params)

    %AppointmentBuilder{
      valid?: initial_changeset.valid?,
      changeset: initial_changeset,
      partials: []
    }
  end

  def complete_partial(appointment, %{model: Appointment} = changeset) do
    changeset
  end

  def build!(builder) do
    appointment = Repo.insert! builder.changeset
    builder.partials 
    |> Enum.map(&complete_partial(appointment, &1))
    |> Enum.map(&Repo.insert!/1)
    appointment
  end
end