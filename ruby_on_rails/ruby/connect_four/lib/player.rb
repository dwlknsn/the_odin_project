class Player
  attr_reader :name, :marker, :automated

  def initialize(name, marker, automated = false)
    @name = name
    @marker = marker
    @automated = automated
  end
end
