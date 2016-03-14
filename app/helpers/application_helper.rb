module ApplicationHelper

  def active_cls(target_path)
    'active' if current_page?(target_path)
  end

  def flash_class(key)
    case key
      when 'success' then 'alert-success'
      when 'notice'  then 'alert-info'
      when 'alert'   then 'alert-warning'
      when 'error'   then 'alert-danger'
      else 'alert-info'
    end
  end

  def flash_glyph(key)
    name = case key
            when 'success' then 'ok-sign'
            when 'notice'  then 'info-sign'
            when 'alert'   then 'alert'
            when 'error'   then 'exclamation-sign'
            else ''
          end
    glyph_tag(name)
  end

  def form_group_class_for(obj, param, success_ind = :show_success_ind)
    if obj.errors.include?(param)
      'form-group has-error has-feedback'
    elsif (success_ind == :show_success_ind) and not obj.attributes[param].nil? and not obj.attributes[param].empty?
      'form-group has-success has-feedback'
    else
      'form-group'
    end
  end

  def form_email_field(form, obj, param, placeholder, explanation = nil, success_ind = :show_success_ind)
    content_tag(:div, class: form_group_class_for(obj, param, success_ind)) do
      form.label(param, class: 'control-label col-md-3') +
          content_tag(:div, class: 'col-md-6') do
            output = form.email_field(param, value: obj.attributes[param], placeholder: t(placeholder), class: 'form-control')
            output += list_errors_for(obj, param)
            unless explanation.nil? then output += content_tag(:p, t(explanation)) end
            output.html_safe
          end
    end
  end

  def form_password_field(form, obj, param, placeholder, explanation = nil, success_ind = :show_success_ind)
    content_tag(:div, class: form_group_class_for(obj, param, success_ind)) do
      form.label(param, class: 'control-label col-md-3') +
          content_tag(:div, class: 'col-md-6') do
            output = form.password_field(param, value: obj.attributes[param], placeholder: t(placeholder), class: 'form-control')
            output += list_errors_for(obj, param)
            unless explanation.nil? then output += content_tag(:p, t(explanation)) end
            output.html_safe
          end
    end
  end

  def form_submit(form, label)
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'col-md-offset-3 col-md-6') do
        form.button label, type: :submit, class: 'btn btn-primary'
      end
    end
  end

  def form_text_field(form, obj, param, placeholder, explanation = nil, success_ind = :show_success_ind)
    content_tag(:div, class: form_group_class_for(obj, param, success_ind)) do
      form.label(param, class: 'control-label col-md-3') +
      content_tag(:div, class: 'col-md-6') do
        output = form.text_field(param, value: obj.attributes[param], placeholder: t(placeholder), class: 'form-control')
        output += list_errors_for(obj, param)
        unless explanation.nil? then output += content_tag(:p, t(explanation)) end
        output.html_safe
      end
    end
  end

  def form_toggle_field(form, obj, param, label, yes_val, no_val, explanation = nil)
    yes_class = 'btn btn-default' + (if obj.attributes[param] then ' active' else '' end)
    no_class  = 'btn btn-default' + (unless obj.attributes[param] then ' active' else '' end)

    content_tag(:div, class: form_group_class_for(obj, param)) do
      content_tag(:div, class: 'control-label col-md-3') do
        content_tag(:p) do
          content_tag(:strong) do
            t(label)
          end
        end
      end +
      content_tag(:div, class: 'col-md-6') do
        content_tag(:div, :class => 'btn-group', :'data-toggle' => 'buttons') do
          content_tag(:label, class: yes_class) do
            form.radio_button(param, true) + t(yes_val)
          end +
          content_tag(:label, class: no_class) do
            form.radio_button(param, false) + t(no_val)
          end
        end
      end +
      content_tag(:div, class: 'col-md-6') do
        output = list_errors_for(obj, param)
        unless explanation.nil? then output += content_tag(:p, t(explanation)) end
        output.html_safe
      end
    end
  end

  def glyph_tag(name, text = '')
    tag = ''
    unless name.nil? or name.empty?
      classes = ['glyphicon', 'glyphicon-' + escape_once(name)]
      tag = content_tag :span, '', :class => classes, :'aria-hidden' => 'true'
      tag += ' '
    end
    tag + text
  end

  def list_errors_for(obj, param, success_ind = :show_success_ind)
    output = ''
    if obj.errors.include? param
      output = content_tag(:span, '', :class => 'glyphicon glyphicon-remove form-control-feedback', :'aria-hidden' => 'true')
      output += content_tag(:ul, '', :class => 'list-unstyled') {
          obj.errors.full_messages_for(param).collect  { |m| content_tag :li, m }.join('').html_safe
        }
    elsif (success_ind == :show_success_ind) and not obj.attributes[param].nil? and not obj.attributes[param].empty?
      output = content_tag(:span, '', :class => 'glyphicon glyphicon-ok form-control-feedback', :'aria-hidden' => 'true')
    end
    output
  end

  def menu_item(name, path, options = {})
    link_name = glyph_tag(options[:glyph]) + name
    content_tag :li,
                link_to(link_name, path, options.except(:glyph)),
                ({class: 'active'} if current_page?(path))
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

end
