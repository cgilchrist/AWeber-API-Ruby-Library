module AWeber
  module Resources
    class WebForm < Resource
      attr_reader :conversion_percentage
      attr_reader :is_active
      attr_reader :name
      attr_reader :total_displays
      attr_reader :total_submissions
      attr_reader :total_unique_displays
      attr_reader :type
      attr_reader :unique_conversion_percentage
    end
  end
end