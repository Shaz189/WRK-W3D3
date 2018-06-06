# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint(8)        not null, primary key
#  user_id   :integer
#  long_url  :string
#  short_url :string
#
require 'base64'

class ShortenedUrl < ApplicationRecord

  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true

  belongs_to :submitter,
    foreign_key: :user_id,
    primary_key: :id,
    class_name: :User

  has_many :visits,
    foreign_key: :url_id,
    primary_key: :id,
    class_name: :Visit

  has_many :visitors, through: :visits,
    source: :visitor


    def self.random_code
       code = SecureRandom.urlsafe_base64()
       while ShortenedUrl.exists?(short_url: code)
         code = SecureRandom.urlsafe_base64()
       end
       code
    end

  def self.create_shortened_url(user, long_url)
    code = ShortenedUrl.random_code
    new_url = ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: code)
  end

  def num_clicks
    self.visits.length
  end

  def num_unique
    self.visitors.select(:id).distinct.count
  end

  def recent_uniques

  end
# User.select(:name)
# # Might return two records with the same name
#
# User.select(:name).distinct
# # Returns 1 record per distinct name
#
# User.select(:name).distinct.distinct(false)
# # You can also remove the uniqueness

end
