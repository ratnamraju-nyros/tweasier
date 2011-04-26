#:stopdoc:
module Google
class  Geo

module Parser
  # Fetch contents of an XML element of the response.
  def fetch(element)
    @xml.slice(%r{<#{element}>(.+?)</#{element}>}, 1)
  end
  
  # Like fetch, but for the only piece of data locked away in an attribute.
  def fetch_accuracy
    @xml.slice(%r{Accuracy="([^"]+)"}, 1).to_i
  end
end

end
end
#:startdoc:
