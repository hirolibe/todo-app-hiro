class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def author_name
    user.display_name
  end

  def display_created_at
    I18n.l(self.created_at, format: :default)
  end
end
