require "simple-mappr/constants"
require "simple-mappr/exceptions"
require "simple-mappr/transporter"
require "simple-mappr/validator"
require "simple-mappr/version"

class SimpleMappr

  def initialize
    @parameters = {}
  end

  ##
  # View the built parameters
  #
  def params
    @parameters
  end

  ##
  # Check if the RESTful API is alive and well
  #
  def alive?
    response = Transporter.ping
    response[:status] == "ok"
  end

  ##
  # Send the SimpleMappr object to the RESTful API
  # and receive a Hash in return containing
  # a URL to the image and its expected expiry
  #
  # == Example Output
  #
  #   {
  #     imageURL: "http://img.simplemappr.net/579273e6_1dd1_2.png",
  #      expiry: "2016-07-22T21:28:38-04:00"
  #   }
  #
  def create
    Transporter.send_data @parameters
  end

  ##
  # Send the SimpleMappr object to the RESTful API and a file title
  # without extension and download the resulting image
  # Returns the file path for the downloaded file
  #
  # == Example
  #
  #   instance.download("/tmp/my_map")
  # Returns
  #   /tmp/my_map.png
  #
  def download(file_title = nil)
    if !file_title
      raise InvalidParameterValue, "File path is required"
    end
    file = [file_title,output].join(".")
    File.open(file, 'wb') do |fo|
      fo.write open(create[:imageURL]).read 
    end
    file
  end

  ##
  # Set a bounding box in decimal degrees as minx,miny,maxx,maxy
  #
  # == Example
  #
  #   instance.bbox = "-120,45,-100,52"
  #
  def bbox=(bbox)
    Validator.validate_bbox(bbox)
    @parameters[:bbox] = bbox
  end

  def bbox
    @parameters[:bbox] || nil
  end

  ##
  # Set the colors in rgb corresponding to the points
  #
  # == Example
  #
  #   instance.color = ["255,0,0","0,255,0"]
  #
  def color=(color)
    Validator.validate_colors(color)
    @parameters[:color] = color
  end

  def color
    @parameters[:color] || nil
  end

  ##
  # Set a file path for a csv or tab-separated text file
  #
  # == Example
  #
  #   instance.file_path = "/Users/SimpleMappr/demo.txt"
  #
  def file_path=(file_path)
    Validator.validate_type(file_path, 'File')
    @parameters[:file] = File.new(file_path, "r")
  end

  def file_path
    @parameters[:file].path rescue nil
  end

  ##
  # Turn on or off the graticules (grid)
  #
  # == Example
  #
  #   instance.graticules = true
  #
  def graticules=(graticules)
    Validator.validate_type(graticules, 'Boolean')
    @parameters[:graticules] = graticules
  end

  def graticules
    @parameters[:graticules] || nil
  end

  ##
  # Specify the height of the image in pixels
  # Maximum value is 4500
  #
  # == Example
  #
  #   instance.height = 1_000
  #
  def height=(height)
    Validator.validate_dimension(height)
    @parameters[:height] = height
  end

  def height
    @parameters[:height] || nil
  end

  ##
  # Specify the layers to include in the image
  # Expressed as a comma-separated String without spaces
  # See SimpleMappr.layers
  #
  # == Example
  #
  #   instance.layers = 'oceans,lakes,rivers'
  #
  def layers=(layers)
    Validator.validate_layers(layers)
    @parameters[:layers] = layers
  end

  def layers
    @parameters[:layers] || nil
  end

  ##
  # Specify the legend title(s)
  # Expressed as an array of Strings corresponding to the points
  #
  # == Example
  #
  #   instance.legend = ['My First Legend','My Second Legend']
  #
  def legend=(legend)
    Validator.validate_type(legend, 'Array')
    @parameters[:legend] = legend
  end

  def legend
    @parameters[:legend] || nil
  end

  ##
  # Specify the origin of natural longitude
  #
  # == Example
  #
  #   instance.origin = -100
  #
  def origin=(origin)
    Validator.validate_origin(origin)
    @parameters[:origin] = origin
  end

  def origin
    @parameters[:origin] || nil
  end

  ##
  # Specify the color in rgb for the outline around all points
  #
  # == Example
  #
  #   instance.outlinecolor = "10,10,10"
  #
  def outlinecolor=(outlinecolor)
    Validator.validate_color(outlinecolor)
    @parameters[:outlinecolor] = outlinecolor
  end

  def outlinecolor
    @parameters[:outlinecolor] || nil
  end

  ##
  # Specify the output file format
  # Options are svg, png, or jpg
  #
  # == Example
  #
  #   instance.output = "png"
  #
  def output=(output)
    Validator.validate_output(output)
    @parameters[:output] = output
  end

  def output
    @parameters[:output] || "png"
  end

  ##
  # An array of geographic coordinates, each as latitude,longitude
  # Group coordinates in array elements, each of which can also be 
  # separated by linebreaks, \n
  #
  # == Example
  #
  #   instance.points = ["45,-120\n45.4,-110","52,-120"]
  #
  def points=(points)
    Validator.validate_points(points)
    @parameters[:points] = points
  end

  def points
    @parameters[:points] || nil
  end

  ##
  # Specify the projection
  # See simple-mappr/constants.rb
  #
  # == Example
  #
  #   instance.projection = "epsg:4326"
  #
  def projection=(projection)
    Validator.validate_projection(projection)
    @parameters[:projection] = projection
  end

  def projection
    @parameters[:projection] || nil
  end

  ##
  # Include an embedded scalebar
  #
  # == Example
  #
  #   instance.scalebar = true
  #
  def scalebar=(scalebar)
    Validator.validate_type(scalebar, 'Boolean')
    @parameters[:scalebar] = scalebar
  end

  def scalebar
    @parameters[:scalebar] || nil
  end

  ##
  # Include shaded regions as a Hash
  # Specify color, title, and places as keys
  #
  # == Example
  #
  #   instance.shade = { color: "200,200,200", title: "My Regions", places: "Canada,US[WY|WA]"}
  #
  def shade=(shade)
    Validator.validate_shade(shade)
    @parameters[:shade] = shade
  end

  def shade
    @parameters[:shade] || nil
  end

  ##
  # Describe the shape to use corresponding to the points
  # See simple-mappr/constants.rb
  #
  # == Example
  #
  #   instance.shape = ['circle','square']
  #
  def shape=(shape)
    Validator.validate_shapes(shape)
    @parameters[:shape] = shape
  end

  def shape
    @parameters[:shape] || nil
  end

  ##
  # Specify the size of the corresponding points
  # Options are Integer less than or equal to 14
  #
  # == Example
  #
  #   instance.size = [8,14]
  #
  def size=(size)
    Validator.validate_sizes(size)
    @parameters[:size] = size
  end

  def size
    @parameters[:size] || nil
  end

  ##
  # Specify the spacing between graticule (grid) lines in degrees
  # Must be an Integer less than or equal to 10
  #
  # == Example
  #
  #   instance.spacing = 5
  #
  def spacing=(spacing)
    Validator.validate_spacing(spacing)
    @parameters[:spacing] = spacing
  end

  def spacing
    @parameters[:spacing] || nil
  end

  ##
  # Specify a remote URL
  # Source must be a csv, a tab-delimited file, or a GeoRSS
  #
  # == Example
  #
  #   instance.url = "http://www.simplemappr.net/public/files/demo.csv"
  #
  def url=(url)
    Validator.validate_url(url)
    @parameters[:url] = url
  end

  def url
    @parameters[:url] || nil
  end

  ##
  # Specify the width of the output in pixels
  # Must be less than or eqaual to 4500
  #
  # == Example
  #
  #   instance.width = 1_000
  #
  def width=(width)
    Validator.validate_dimension(width)
    @parameters[:width] = width
  end

  def width
    @parameters[:width] || nil
  end

  ##
  # Include wkt regions as a Hash
  # Specify color, title, and data as keys
  #
  # == Example
  #
  #   instance.wkt = { color: "200,200,200", title: "My Regions", data: "POLYGON((-70 63,-70 48,-106 48,-106 63,-70 63))"}
  #
  def wkt=(wkt)
    Validator.validate_wkt(wkt)
    @parameters[:wkt] = wkt
  end

  def wkt
    @parameters[:wkt] || nil
  end

  ##
  # Specify a zoom level, centred on the geographic center of all points
  # Must be less than or eqaual to 10
  #
  # == Example
  #
  #   instance.zoom = 3
  #
  def zoom=(zoom)
    Validator.validate_zoom(zoom)
    @parameters[:zoom] = zoom
  end

  def zoom
    @parameters[:zoom] || nil
  end

end