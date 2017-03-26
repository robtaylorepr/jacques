class NoteSerializer < ActiveModel::Serializer

  attributes  :title, :body, :id,
              :created_at, :updated_at
  has_many    :tags
  belongs_to  :user

end
