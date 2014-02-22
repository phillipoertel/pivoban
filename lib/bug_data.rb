class BugData
  # required object:
  # [ 
  #   { 
  #     "key" : "First row label", 
  #     "values" : [ [ x1, y1] , [ x2, y2] ]
  #     }, 
  #   // ...
  # ]
  def self.load
    [
      { key: 'Opened bugs', values: [ [1, 1], [2, 3], [3, 5] ] }, 
      { key: 'Closed bugs', values: [ [1, 0], [2, 1], [3, 3] ] }
    ]
  end
end