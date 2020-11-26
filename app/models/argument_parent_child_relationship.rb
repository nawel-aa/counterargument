class ArgumentParentChildRelationship < ApplicationRecord
  belongs_to :child, class_name: 'Argument'
  belongs_to :parent, class_name: 'Argument'
end
