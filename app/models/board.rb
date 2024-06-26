# == Schema Information
#
# Table name: boards
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_boards_on_user_id  (user_id)
#
class Board < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :tasks, dependent: :destroy

  def task_authors
    task_authors = Set.new
    author_ids = Set.new

    self.tasks.each do |task|
      unless author_ids.include?(task.user.id)
        task_authors.add(task.user)
        author_ids.add(task.user.id)
      end
    end

    task_authors
  end
end