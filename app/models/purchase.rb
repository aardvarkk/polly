class Purchase < ApplicationRecord
  belongs_to :code
  belongs_to :department
  monetize :amount_cents
end
