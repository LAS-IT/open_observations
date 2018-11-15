module ApplicationHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def text_icon(icon,options={})
    css_classes = ["fa fa-#{icon.to_s.gsub(/\_/,'-')}"]
    css_classes << 'fa-fw' if options[:fixed_width]
    css_classes << 'fa-spin' if options[:spin]
    css_classes << 'fa-lg' if options[:lg]
    css_classes << 'fa-2x' if options[:x2]
    css_classes << 'fa-3x' if options[:x3]
    css_classes << 'fa-4x' if options[:x4]
    css_classes << 'fa-5x' if options[:x5]
    css_classes << 'fa-stack' if options[:stack]
    css_classes << 'fa-stack-2x' if options[:stack2x]
    css_classes << 'fa-stack-3x' if options[:stack3x]
    css_classes << 'fa-stack-4x' if options[:stack4x]
    css_classes << 'fa-stack-5x' if options[:stack5x]
    css_classes << 'fa-inverse' if options[:inverse]
    capture_haml do
      haml_tag :i, class: css_classes.join(' ')
    end
  end

  def page_title(title=nil)
    title || t("modules.#{params[:controller]}")
  end

  def errors_for(object)
    if object.errors.any?
      object_name = t("models.#{object.class.name.underscore.downcase}", default: object.class.name.titleize)
      capture_haml do
        haml_tag :div, class: 'errors' do
          haml_tag :p, "#{pluralize(object.errors.count, 'error')} prohibited this #{object_name} from being saved"
          haml_tag :ul do
            object.errors.full_messages.each do |error|
              haml_tag :li, error
            end
          end
        end
      end
    end
  end

  def submit_for(object,options={})
    unless options[:skip_cancel]
      options[:cancel_label] ||= t('admin.cancel')
      options[:cancel_path] ||= object.new_record? ? polymorphic_path((options[:parent] || object.class)) : polymorphic_path(object) 
    end
    options[:save_label] ||= t('admin.save')
    capture_haml do 
      grid do
        column of: 4 do
          haml_tag :button, options[:save_label], class: 'pure-button pure-button-primary pure-button-large'
        end
        unless options[:skip_cancel]
          column width: 3, of: 4 do
            haml_tag :p, class: 'cancel' do
              haml_concat 'or'
              haml_concat link_to(t('admin.cancel'), options[:cancel_path])
            end
          end
        end
      end
    end
  end

  def grid(&block)
    haml_tag :div, class: 'pure-g' do
      block.call
    end
  end

  def column(options={}, &block)
    options[:width] ||= 1
    options[:of] ||= 2
    classes = []
    classes << "pure-u-#{options[:width]}-#{options[:of]}"
    classes << options[:class] if options.key?(:class)
    haml_tag :div, class: classes.join(' ') do
      block.call
    end
  end

  def table_for(objects, options={})
    capture_haml do
      if objects.any?
        klass = objects.first.class.name
        haml_tag :table, class: 'pure-table pure-table-horizontal pure-table striped', id: klass.underscore.pluralize do
          if options.key?(:columns)
            haml_tag :thead do
              haml_tag :tr do
                options[:columns].each do |attribute| 
                  haml_tag :th, t("activerecord.attributes.#{klass.underscore}.#{attribute}")
                end
                unless options[:skip_actions]
                  haml_tag :th, ''
                end
              end
            end 
            haml_tag :tbody do
              haml_concat render(objects)
            end
          else
            haml_concat render(objects)
          end
        end
      else
        haml_tag :p, t('admin.no_records'), class: 'no-records'  
      end
    end 
  end

  def form_page_for(object, options={})
    capture_haml do
      unless options.key?(:header)
        key = object.new_record? ? 'modules.actions.defaults.new' : 'modules.actions.defaults.edit'
        klass_name = t("activerecord.models.#{object.class.name.underscore}")
        options[:header] = t(key, resource: klass_name)
      end
      haml_tag :h2, options[:header], class: 'content-subhead'
      grid do
        column of: 2 do
          haml_concat render('form')
        end
      end
    end
  end

  def yes_no(boolean, options={})
    options[:yes] ||= 'Yes'
    options[:no] ||= 'No'
    boolean ? options[:yes] : options[:no]
  end

  def link_to_object(object, options={})
    link_to object, object, options
  end
end
