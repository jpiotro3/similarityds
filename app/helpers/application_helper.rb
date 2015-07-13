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

  def form_group_class_for(obj, param)
    if obj.errors.include?(param)
      'form-group has-error has-feedback'
    elsif not obj.attributes[param].nil? and not obj.attributes[param].empty?
      'form-group has-success has-feedback'
    else
      'form-group'
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

  def list_errors_for(obj, param)
    output = ''
    if obj.errors.include? param
      output = content_tag(:span, '', :class => 'glyphicon glyphicon-remove form-control-feedback', :'aria-hidden' => 'true')
      output += content_tag(:ul, '', :class => 'list-unstyled') {
          obj.errors.full_messages_for(param).collect  { |m| content_tag :li, m }.join('').html_safe
        }
    elsif not obj.attributes[param].nil? and not obj.attributes[param].empty?
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
