json.nodes do
  json.array! @arguments do |argument|
    json.id "n#{argument.id}"
    json.label argument.content
    json.x rand
    json.y rand
    json.size 2
  end
end

json.edges do
  index = 0
  json.array! @relationships do |relationship|
    json.id "e#{index}"
    json.source "n#{relationship.parent_id}"
    json.target "n#{relationship.child_id}"
    index += 1
  end
end
