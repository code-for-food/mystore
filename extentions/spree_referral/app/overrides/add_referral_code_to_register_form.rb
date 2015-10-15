# Deface::Override.new(:virtual_path => 'spree/shared/_user_form',
#     :name => 'add_referral_code_to_register_form',
#     :insert_after => "erb[loud]:contains('password_field :password_confirmation')",
#     :text => "
#         <%= f.field_container :referral_code, :class => ['form-group'] do %>
#             <%= f.label :referral_code, Spree.t(:referral_code) %>
#             <%= f.text_field :referral_code  %>
#             <%= f.error_message_on :referral_code %>
#         <% end %>
#     ")
