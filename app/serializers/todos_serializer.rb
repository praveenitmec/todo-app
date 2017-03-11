class TodosSerializer < ActiveModel::Serializer
  attributes :id, :name, :target_date, :user_name

  def user_name
    object.user.name
  end
end
