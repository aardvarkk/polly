class Purchase < ApplicationRecord
  belongs_to :code
  belongs_to :department
  belongs_to :location
  belongs_to :contract_style
  monetize :amount_cents
end
