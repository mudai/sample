class CustomField < ActiveRecord::Base
  has_many :custom_values, :dependent => :delete_all

  serialize :possible_values
 
  validate :name, presence: true, uniqueness: {scope: :type}, length: {maximum: 20}
  validate :field_format, presence: true, inclusion: { in: ["string", "text", "int", "float", "list", "bool"] }

  delegate :string?, :text?, :int?, :float?, :list?, :bool?, to: :field_format_with_inquiry, allow_nil: true, prefix: 'format'

  private
  def field_format_with_inquiry
    field_format.try(:inquiry)
  end
end
