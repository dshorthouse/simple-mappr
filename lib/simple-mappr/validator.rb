require "uri"

class SimpleMappr
  class Validator

    def self.validate_bbox(data)
      validate_type(data, 'String')
      coords = data.split(",")
      if coords.length != 4
        raise InvalidParameterValue, "bbox must have four parameters in the form -110,45,-100,52"
      end
      validate_coordinate(coords[1].to_f, coords[0].to_f)
      validate_coordinate(coords[3].to_f, coords[2].to_f)
    end

    def self.validate_coordinate(latitude, longitude)
      if latitude > 90 || latitude < -90 || longitude > 180 || longitude < -180
        raise InvalidParameterValue, "Coordinate latitude,longitude=#{latitude},#{longitude} is not valid"
      end
    end

    def self.validate_colors(data)
      validate_type(data, 'Array')
      data.each { |item| validate_color(item) }
    end

    def self.validate_color(data)
      validate_type(data, 'String')
      rgb = data.split(",")
      if rgb.length != 3
        raise InvalidParameterValue, "color must have three parameters in the form 0,0,0"
      end
      rgb.each do |item|
        begin
          Integer(item || '')
        rescue ArgumentError
          raise InvalidParameterValue, "color value must be an integer <= 255"
        end
        if item.to_i > 255
          raise InvalidParameterValue, "color value must be an integer <= 255"
        end
      end
    end

    def self.validate_dimension(data)
      validate_type(data, 'Integer')
      if data > 4_500
        raise InvalidParameterValue, "Accepted integer values are <= 4500"
      end
    end

    def self.validate_points(data)
      validate_type(data, 'Array')
      data.each { |item| validate_type(item, 'String') }
    end

    def self.validate_shapes(data)
      validate_type(data, 'Array')
      data.each do |item|
        if !SHAPES.include?(item)
          raise InvalidParameterValue, "Values must each be one of #{SHAPES.join(", ")}"
        end
      end
    end

    def self.validate_sizes(data)
      validate_type(data, 'Array')
      data.each do |item|
        validate_type(item, 'Integer')
        if item > 14
          raise InvalidParameterValue, "Values must each be integers less than 14"
        end
      end
    end

    def self.validate_shadows(data)
      validate_type(data, 'Array')
      data.each { |item| validate_type(item, 'Boolean') }
    end

    def self.validate_url(data)
      validate_type(data, 'String')
      if data !~ /\A#{URI::regexp(['http', 'https'])}\z/
        raise InvalidParameterValue, "URL must be in the form http:// or https://"
      end
    end

    def self.validate_zoom(data)
      validate_type(data, 'Integer')
      if data > 10
        raise InvalidParameterValue, "Accepted integer value is <= 10"
      end
    end

    def self.validate_shade(data)
      validate_type(data, 'Hash')
      data = data.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
      if !(data.keys - [:places, :title, :color]).empty?
        raise InvalidParameterValue, "Shade must be Hash in the form { places: \"\", title: \"\", color: \"\" }"
      end
      if data.key?(:color)
        validate_color(data[:color])
      end
    end

    def self.validate_layers(data)
      validate_type(data, 'String')
      if !(data.split(",") - LAYERS).empty?
        raise InvalidParameterValue, "Accepted layers are combinations of #{LAYERS.join(",")}"
      end
    end

    def self.validate_projection(data)
      if !PROJECTIONS.include?(data)
        raise InvalidParameterValue, "Accepted projection value is one of #{PROJECTIONS.join(",")}"
      end
    end

    def self.validate_origin(data)
      validate_type(data, 'Integer')
      if data > 180 || data < -180
        raise InvalidParameterValue, "Accepted integer values are -180 <= x <= 180"
      end
    end

    def self.validate_spacing(data)
      validate_type(data, 'Integer')
      if data > 10
        raise InvalidParameterValue, "Accepted integer values are <= 10"
      end
    end

    def self.validate_output(data)
      if !OUTPUTS.include?(data)
        raise InvalidParameterValue, "Accepted outputs are #{OUTPUTS.join(", ")}"
      end
    end

    def self.validate_type(data, type)
      case type
      when 'String', 'Array', 'Integer', 'Hash'
        raise InvalidParameterValue, "Must be a #{type}" unless data.is_a?(Object.const_get(type))
      when 'Boolean'
        raise InvalidParameterValue, "Must be a Boolean" unless [true, false].include?(data)
      when 'File'
        raise InvalidParameterValue, "Must be a file path & file must exist" unless File.file?(data)
      end
    end

    def self.validate_wkt(data)
      validate_type(data, 'Array')
      data.each { |item| validate_type(item, 'Hash') }
      if !(data[0].keys - [:data, :title, :color, :border]).empty?
        raise InvalidParameterValue, "wkt must be an Array of Hashes in the form [{ data: \"\", title: \"\", color: \"\", border: \"\" }]"
      end
      if data[0].key?(:color)
        validate_color(data[0][:color])
      end
    end

  end
end