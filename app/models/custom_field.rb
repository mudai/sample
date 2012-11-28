# -*- coding: utf-8 -*-

class CustomField < ActiveRecord::Base
  belongs_to :custom_box
  has_many :custom_values, dependent: :delete_all

  serialize :possible_values
 
  validate :title, presence: true, uniqueness: {scope: :custom_box_id}, length: {maximum: 20}
  validate :field_format, presence: true, inclusion: { in: ["string", "text", "int", "float", "list", "bool"] }

  delegate :string?, :text?, :int?, :float?, :list?, :bool?, to: :field_format_with_inquiry, allow_nil: true, prefix: 'format'

  private
  def field_format_with_inquiry
    field_format.try(:inquiry)
  end
end
