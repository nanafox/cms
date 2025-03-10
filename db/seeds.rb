if ChurchManagement::Chapel.all.empty?
  ChurchManagement::Chapel.names.keys.each_with_index do |chapel, quarter|
    ChurchManagement::Chapel.create!(
      name: chapel.titlecase,
      color: ChurchManagement::Chapel.colors.keys[quarter],
      quarter: quarter + 1
    )
  end
end
