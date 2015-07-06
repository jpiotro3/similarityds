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

  def glyph_tag(name, text = '')
    tag = ''
    unless name.nil? or name.empty?
      classes = ['glyphicon', 'glyphicon-' + escape_once(name)]
      tag = content_tag :span, '', :class => classes, :'aria-hidden' => 'true'
      tag += ' '
    end
    tag + text
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
