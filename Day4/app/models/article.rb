class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  before_validation :set_defaults
  validates :title, :content, presence: true

  private

  def set_defaults
    self.reports_count ||= 0
    self.archived = false if archived.nil?
  end


end