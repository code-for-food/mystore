Deface::Override.new(:virtual_path => 'spree/admin/shipping_methods/_form',
    :name => 'add_delivered_days_to_shipping_method_edit',
    :insert_after => "erb[loud]:contains('text_field :name')",
    :text => "
        <%= f.field_container :delivered_days, :class => ['form-group'] do %>
            <%= f.label :delivered_days, raw(Spree.t(:delivered_days) + content_tag(:span, ' *')) %>
            <%= f.select(:delivered_days, [['After shipped 1 day', 1], ['After shipped 2 days', 2], ['After shipped 3 days', 3], ['After shipped 4 days', 4], ['After shipped 5 days', 5], ['After shipped 6 days', 6], ['After shipped 7 days', 7], ['After shipped 8 days', 8], ['After shipped 9 days', 9], ['After shipped 10 days', 10]],{},{:selected => 3, :class => 'select2' }) %>
            <%= f.error_message_on :delivered_days %>
        <% end %>
    ")
