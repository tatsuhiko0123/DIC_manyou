class Task < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels
  validates :title, presence: true
  validates :content, presence: true
  validates :expired_at, presence: true
  validates :status, presence: true
  validates :user_id, presence: true
  scope :search_title, -> (search_title) { where("title LIKE ?", "%#{search_title}%") }
  scope :search_status, -> (search_status) { where(status: search_status)}
  scope :search_label, -> (search_label) { joins(:labels).where(labels: { id: search_label })}
  enum status: { 未着手: 1, 着手: 2, 完了: 3 }
  enum priority: { 高: 1, 中: 2, 低: 3 }
end
