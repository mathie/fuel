module ApplicationHelper
  # Given:
  #
  # <%= form_input f, :text_field, :email, label: 'Email address', autofocus: true, class: 'xlarge', size: 30 %>
  #
  # Return something like:
  #
  # <div class="clearfix<%= ' error' if resource.errors.include?(:email) %>">
  #   <%= f.label :email, 'Email Address' %>
  #   <div class="input">
  #     <%= f.text_field :email, autofocus: true, class: 'xlarge', size: 30 %>
  #     <% if resource.errors.include?(:email) %>
  #       <span class="help-inline"><%= resource.errors[:email].to_sentence %></span>
  #     <% end %>
  #   </div>
  # </div>
  #
  # It's not perfect, and it should live on FormHelper so you can do +form.text_input ...+ but it'll do for now.
  def form_text_input(form, input_type, attribute, options = {})
    label_string = options.delete(:label)
    hint = options.delete(:hint)

    content_tag(:div, class: "clearfix#{' error' if form.object.errors.include?(attribute)}") do
      if label_string.present?
        concat form.label(attribute, label_string)
      else
        concat form.label(attribute)
      end

      input = content_tag(:div, class: 'input') do
        concat form.send(input_type, attribute, options)
        if form.object.errors.include?(attribute)
          concat content_tag(:span, form.object.errors[attribute].to_sentence, class: 'help-inline')
        end

        if hint.present?
          concat content_tag(:span, hint, class: 'help-block')
        end
      end
      concat input
    end
  end
end
