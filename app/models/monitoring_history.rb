class MonitoringHistory < ActiveRecord::Base
  belongs_to :user
  scope :today, -> { where(recorded_on: Date.today) }
  scope :recent, ->(date) { where arel_table[:recorded_on].gt(date) }
end
