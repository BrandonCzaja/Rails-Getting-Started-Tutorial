# This concern is dealing with the visibility of articles and comments - Concerns should be very focused and reusable
module Visible
  extend ActiveSupport::Concern

  # Taken from the Article and Comment models to remove duplication
  VALID_STATUSES = ["public", "private", "archived"]

  included do
    validates :status, inclusion: { in: VALID_STATUSES }
  end

  # Class methods can be added to concerns
  class_methods do
    def public_count
      where(status: "public").count
    end
  end

  def archived?
    status == "archived"
  end
end