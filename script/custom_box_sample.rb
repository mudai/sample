# -*- coding: utf-8 -*-
#
box = CustomBox.create!(title: "体重", box_type: CustomBox::Type::Monitoring, is_required: false, editable: false, position: 1)
field = box.custom_fields.new(title: "朝", unit: "kg", field_format: "float", position: 1)
field.save
value = field.custom_values.new
value.custom_box = box
value.value = "100"
value.save

