module ApplicationHelper

  def flash_class(key)
    case key
      when 'success' then 'alert-success'
      when 'notice'  then 'alert-info'
      when 'alert'   then 'alert-warning'
      when 'error'   then 'alert-danger'
      else 'alert-info'
    end
  end

  def flash_header(key)
    case key
      when ':success' then 'Success!'
      when 'notice'   then ''
      when 'alert'    then 'Warning!'
      when 'error'    then 'Error!'
      else ''
    end
  end

  def active_cls(target_path)
    'active' if current_page?(target_path)
  end

end
