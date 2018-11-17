class Code < ApplicationRecord
	belongs_to :source
	has_one :category
end
