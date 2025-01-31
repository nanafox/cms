require_relative "../church_managment"

class ChurchManagment::Chapel < ChurchManagment::ResourceRecord
  validates :name, presence: true
  validates :color, presence: true
  validates :quarter, presence: true

  enum :name, love: "Love", faith: "Faith", joy: "Joy", peace: "Peace"
  enum :color, red: "Red", green: "Green", yellow: "Yellow", blue: "Blue"
end
