# NOTE: Gate = 改札機のイメージ
class Gate < ApplicationRecord
  FARES = [150, 190].freeze

  validates :name, presence: true, uniqueness: true
  validates :station_number, presence: true, uniqueness: true

  scope :order_by_station_number, -> { order(:station_number) }

  def exit?(ticket)
    return false if station_number == ticket.entered_gate.station_number
    return false if ticket.fare < FARES[ section(ticket) - 1 ]
    true
  end

  def section(ticket)
    (ticket.entered_gate.station_number - station_number).abs
  end
end
