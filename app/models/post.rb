# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  belongs_to :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :User




end
