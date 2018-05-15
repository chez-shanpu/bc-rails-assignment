class Article < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true

  # PV上位５つを返す
  def self.most_popular(limit: 5)
    most_popular_ids = REDIS.zrevrangebyscore "articles", "+inf", 0, limit: [0, limit]
    where(id: most_popular_ids).sort_by {|article| most_popular_ids.index(article.id.to_s)}
  end

  # count of PV
  def redis_page_view
    REDIS.zscore("articles", self.id).floor
  end
end
