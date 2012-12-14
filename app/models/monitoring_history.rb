class MonitoringHistory < ActiveRecord::Base
  belongs_to :user
  scope :today, -> { where(recorded_on: Date.today) }
end
