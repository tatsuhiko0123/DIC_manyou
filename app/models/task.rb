class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status: search_status)}
  enum status: { 未着手: 1, 着手: 2, 完了: 3 }
end
