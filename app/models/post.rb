class Post < ApplicationRecord
    #belongs_to :user
    validates :post_content, :presence => true
    acts_as_votable cacheable_strategy: :update_columns
end
