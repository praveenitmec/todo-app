class TodoSerializer < ActiveModel::Serializer
  attributes :id, :name, :target_date
end
