class Post < ApplicationRecord
    #belongs_to :user
    #validates :user_id, presence: true
   acts_as_votable cacheable_strategy: :update_columns
end
