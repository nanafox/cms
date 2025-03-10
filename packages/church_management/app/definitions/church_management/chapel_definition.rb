class ChurchManagement::ChapelDefinition < ChurchManagement::ResourceDefinition
  display :name, formatter: ->(value) { value.titleize }
  display :color, formatter: ->(value) { value.titleize }

  display :quarter,
    formatter: ->(value) {
      case value
      when "1"
        "First"
      when "2"
        "Second"
      when "3"
        "Third"
      when "4"
        "Fourth"
      end
    }
end
