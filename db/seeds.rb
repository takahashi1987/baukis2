table_names = %w(staff_members administrators staff_events customers)

table_names.each do |table_name|
  path = Rails.root.join("db/seeds/#{Rails.env}/#{table_name}.rb")
  if File.exist?(path)
    p "Creating #{table_name}..."
    require(path)
  end
end
