class SimpleMappr

  API_URL = "http://www.simplemappr.net/api/"

  PROJECTIONS = [
    'epsg:4326',
    'esri:102009',
    'esri:102015',
    'esri:102014',
    'esri:102012',
    'esri:102024',
    'epsg:3112',
    'epsg:102017',
    'epsg:102019'
  ]

  SHAPES = [
    'plus',
    'cross',
    'asterisk',
    'circle',
    'square',
    'triangle',
    'inversetriangle',
    'star',
    'hexagon',
    'opencircle',
    'opensquare',
    'opentriangle',
    'inverseopentriangle',
    'openstar',
    'openhexagon'
  ]

  LAYERS = [
    'countries',
    'countrynames',
    'relief',
    'reliefgrey',
    'stateprovinces',
    'stateprovnames',
    'lakes',
    'lakesOutline',
    'lakenames',
    'rivers',
    'rivernames',
    'oceans',
    'marineLabels',
    'placenames',
    'physicalLabels',
    'ecoregions',
    'ecoregionLabels',
    'conservation',
    'hotspotLabels',
    'blueMarble'
  ]

  OUTPUTS = ['svg', 'png', 'jpg']

  def self.api_url
    API_URL
  end

  def self.shapes
    SHAPES
  end

  def self.projections
    PROJECTIONS
  end

  def self.layers
    LAYERS
  end

  def self.outputs
    OUTPUTS
  end

end