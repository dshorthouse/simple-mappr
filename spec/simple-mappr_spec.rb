describe "SimpleMappr" do
  subject { SimpleMappr }
  let(:sm) { subject.new }

  describe ".version" do
    it "returns version" do
      expect(subject.version).to match /\d+\.\d+\.\d+/
    end
  end

  describe ".new" do
    it "works" do
      expect(sm).to be_kind_of SimpleMappr
    end
  end

  describe "#params" do

    context "bbox" do
      it "accepts properly formatted bbox" do
        bbox = "-120,45,-100,52"
        sm.bbox = bbox
        expect(sm.bbox).to eq(bbox)
      end
      it "raises exception for missing coordinates in bbox" do
        expect{sm.bbox = "-120,-100,45"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for improperly arranged first coordinate pair in bbox" do
        expect{sm.bbox = "-120,-100,45,52"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for improperly arranged second coordinate pair in bbox" do
        expect{sm.bbox = "-120,45,52,-100"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "color" do
      it "accepts properly formatted color" do
        color = ['255,0,0']
        sm.color = color
        expect(sm.color).to eq(color)
      end
      it "raises exception for color not an Array" do
        expect{sm.color = "255,0,0"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for string in a value for color" do
        expect{sm.color = ["255,test,0"]}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for non-Integer in a value for color" do
        expect{sm.color = ["255,0.5,0"]}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for a value for color > 255" do
        expect{sm.color = ["256,0,0"]}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "file_path" do
      it "accepts a valid file_path" do
        file_path = File.join(__dir__, "files", "demo.txt")
        sm.file_path = file_path
        expect(sm.file_path).to eq(file_path)
      end
      it "raises an exception for an invalid file_path" do
        file_path = File.join(__dir__, "files", "none.txt")
        expect{sm.file_path = file_path}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "graticules" do
      it "accepts true for graticules and returns true" do
        sm.graticules = true
        expect(sm.graticules).to be true
      end
      it "accepts false for graticules and returns nil" do
        sm.graticules = false
        expect(sm.graticules).to be nil
      end
      it "it raises an exception with invalid graticules" do
        expect{sm.graticules = "true"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "height" do
      it "accepts a valid integer for the height" do
        sm.height = 1_000
        expect(sm.height).to eq(1_000)
      end
      it "raises an exception with a string as a height" do
        expect{sm.height = "1000"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception with a height that is too large" do
        expect{sm.height = 5_000}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "layers" do
      it "accepts all layers" do
        sm.layers = subject::LAYERS.join(",")
        expect(sm.layers).to eq(subject::LAYERS.join(","))
      end
      it "raises an exception with an invalid layer" do
        expect{sm.layers = "oceans,nothing"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "legend" do
      it "acccepts a validly formed legend as an Array" do
        legend = ["My Legend"]
        sm.legend = legend
        expect(sm.legend).to eq(legend)
      end
      it "raises an exception if legend is not an Array" do
        expect{sm.legend = "My Legend"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "origin" do
      it "accepts a valid integer for the origin" do
        sm.origin = -120
        expect(sm.origin).to eq(-120)
      end
      it "raises an exception with a string as an origin" do
        expect{sm.origin = "120"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception with an origin that is too small" do
        expect{sm.origin = -181}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "outlinecolor" do
      it "accepts properly formatted outlinecolor" do
        outlinecolor = "255,0,0"
        sm.outlinecolor = outlinecolor
        expect(sm.outlinecolor).to eq(outlinecolor)
      end
      it "raises exception for outlinecolor not an String" do
        expect{sm.outlinecolor = ["255,0,0"]}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for string in a value for outlinecolor" do
        expect{sm.outlinecolor = "255,test,0"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for non-Integer in a value for outlinecolor" do
        expect{sm.outlinecolor = "255,0.5,0"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises exception for a value for outlinecolor > 255" do
        expect{sm.outlinecolor = "256,0,0"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "output" do
      it "accepts a valid output format" do
        sm.output = "svg"
        expect(sm.output).to eq("svg")
      end
      it "accepts a valid output format" do
        sm.output = "png"
        expect(sm.output).to eq("png")
      end
      it "accepts a valid output format" do
        sm.output = "jpg"
        expect(sm.output).to eq("jpg")
      end
      it "raises an exception for an unrecocgnized output value" do
        expect{sm.output = "nothing"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "points" do
      it "accepts a valid input for points" do
        points = ["45, -120", "52, -100"]
        sm.points = points
        expect(sm.points).to eq(points)
      end
      it "raises an exception for points not in Array" do
        expect{sm.points = "45, -120"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "projection" do
      it "accepts a valid projection" do
        projection = "epsg:4326"
        sm.projection = projection
        expect(sm.projection).to eq(projection)
      end
      it "raises an exception for an unrecocgnized projection value" do
        expect{sm.projection = "epsg:19009"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "scalebar" do
      it "accepts true for scalebar and returns true" do
        sm.scalebar = true
        expect(sm.scalebar).to be true
      end
      it "accepts false for scalebar and returns nil" do
        sm.scalebar = false
        expect(sm.scalebar).to be nil
      end
      it "it raises an exception with invalid scalebar" do
        expect{sm.scalebar = "true"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "shade" do
      it "accepts a hash as a value for shade" do
        shade = { title: "My title", color: "255,0,0", places: "Canada" }
        sm.shade = shade
        expect(sm.shade).to eq(shade)
      end
      it "raises an exception if shade is not a Hash" do
        expect{sm.shade = "{'color' => 'none'}"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception if shade has an unrecognized hash key" do
        expect{sm.shade = { bad_key: "blank"}}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception if shade has an unrecognized color value" do
        expect{sm.shade = { color: "256,0,0"}}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "shape" do
      it "accepts a valid shape as an Array" do
        shape = ['circle', 'square']
        sm.shape = shape
        expect(sm.shape).to eq(shape)
      end
      it "raises an exception if there's an invalid shape" do
        expect{sm.shape = "circle,square"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception if there's an invalid shape" do
        expect{sm.shape = ["circle","squared"]}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "size" do
      it "accepts a valid size as an Array" do
        size = [10,14]
        sm.size = size
        expect(sm.size).to eq(size)
      end
      it "raises an exception for non-Integer values for size in Array" do
        expect{sm.size = ['10',14]}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception for too large values for size" do
        expect{sm.size = [15,14]}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "spacing" do
      it "accepts a valid integer for the spacing of graticules" do
        sm.spacing = 4
        expect(sm.spacing).to eq(4)
      end
      it "raises an exception with a string for spacing" do
        expect{sm.spacing = "4"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception with spacing that is too large" do
        expect{sm.spacing = 11}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "url" do
      it "it accepts a valid URL" do
        url = "http://www.simplemappr.net"
        sm.url = url
        expect(sm.url).to eq(url)
      end
      it "it raises exception with invalid URL" do
        expect{sm.url = "ftp://www.simplemappr.net"}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "width" do
      it "accepts a valid integer for the height" do
        sm.height = 1_000
        expect(sm.height).to eq(1_000)
      end
      it "raises an exception with a string as a height" do
        expect{sm.height = "1000"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception with a height that is too large" do
        expect{sm.height = 5_000}.to raise_error(subject::InvalidParameterValue)
      end
    end

    context "zoom" do
      it "accepts a valid integer for the zoom" do
        sm.zoom = 4
        expect(sm.zoom).to eq(4)
      end
      it "raises an exception with a string as a zoom" do
        expect{sm.zoom = "4"}.to raise_error(subject::InvalidParameterValue)
      end
      it "raises an exception with a zoom that is too large" do
        expect{sm.zoom = 11}.to raise_error(subject::InvalidParameterValue)
      end
    end

  end

  def read(file)
    File.read(File.join(__dir__, "files", file))
  end

end
