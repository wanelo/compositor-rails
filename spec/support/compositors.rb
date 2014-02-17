require 'compositor'
require 'oj'

class StringCompositor < Compositor::Leaf
  attr_accessor :string
  
  def to_hash
    with_root_element do
      { 'string' => string.to_s }
    end
  end
end