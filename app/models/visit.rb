class Visit < ApplicationRecord

  belongs_to :visited_url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

  belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User



end
