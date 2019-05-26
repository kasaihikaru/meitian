class Theme < ApplicationRecord
  scope :this_month, -> { where(yearmonth: Date.today.beginning_of_month) }
end