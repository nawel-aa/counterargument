# These three lines will create an Array of arguments and the elements of this
# Array will be objects with two keys of id and content

json.array! @arguments do |argument|
  json.extract! restaurant, :id, :content
end
