module ProlearningHelper
  def prolearning_menu
    controller = params[:controller].gsub(/\_controller/)    
    action = params[:action]
    capture_haml do
      haml_tag :a, class: 'pure-menu', id: 'pure-menu-link', href: '#menu' do 
        haml_tag :span
      end
      haml_tag :div, id: 'menu' do
        haml_tag :div, class: 'pure-menu pure-menu-open' do
          haml_concat link_to(t('modules.menu_header'), root_path, class: 'pure-menu-heading')
          haml_tag :ul, class: '' do
            haml_concat(render('prolearning/menu', locals: { controller: controller, action: action }))
          end
        end
      end
    end
  end

  def prolearning_menu_item(*args)
    options = args.extract_options!
    if args[0].is_a? String
      title = args[0]
      location = args[1] || '#'
    elsif args[0].is_a? Symbol
      title = t("modules.#{args[0]}")
      location = args[1] || url_for(controller: args[0])
      options[:icon] ||= args[0]
    end

    css_class = []
    css_class << "menu-item-divided" if options[:break] == true
    css_class << "pure-menu-selected" if false

    if options[:icon].present?
      title = raw("<i class='fa-fw fa fa-#{options[:icon].to_s.gsub(/\_/,'-')}'></i>#{title}")
    end

    options[:html] ||= {}
    options[:html].merge!({ class: css_class.join(' ')})
    content_tag :li do
      link_to title, location, options[:html]
    end
  end

  def basic_button(label, href, options={})
    label = "#{text_icon(options[:icon])}#{label}" if options[:icon]
    options[:class] ||= 'pure-button pure-button-large'
    html_options = {}
    html_options[:class] = options[:class]
    html_options[:id] = options[:id] if options.key?(:id)
    link_to raw(label), href, html_options
  end

  def primary_button(label, href, options={})
    classes = %w(pure-button pure-button-primary) 
    classes << 'pure-button-large' unless options[:large].eql?(false)
    options[:class] = classes.join(' ')
    basic_button label, href, options 
  end

  def object_actions(*args)
    options = args.extract_options!
    object = args.shift  
    acl_object = object.is_a?(Array) ? object.last : object
    html = []
    if args.any?
      args.each do |action|
        html << link_to(action.first, action.second)
      end
    end 
    if can?(:read, acl_object) && !options[:skip_view]
      html << link_to(text_icon(:eye), polymorphic_path(object))
    end
    if can?(:edit, acl_object) && !options[:skip_edit]
      edit_path = "edit_#{object.class.name.underscore}_path"
      html << link_to(text_icon(:pencil), edit_polymorphic_path(object), "data-no-turbolink" => true)
    end
    if can?(:destroy, acl_object) && !options[:skip_destroy]
      options[:confirm] ||= 'Are you sure? This action cannot be undone!'
      html << link_to(text_icon(:trash_o), object, method: :delete, confirm: options[:confirm] )
    end
    html.join(' ').html_safe
  end

  def show_page_for(object, options={})
    if object.is_a? Array
      parent = object.first
      object = object.last
    else
      parent = nil
    end
    options[:buttons] ||= []
    capture_haml do
      grid do
        column width: 1, of: 2 do
          options[:header] ||= object.to_s
          haml_tag :h2, options[:header], class: 'content-subhead'
        end
        column width: 1, of: 2, class: 'action-button' do
          klass = t("activerecord.models.#{object.class.name.underscore}")
          haml_tag :p do
            options[:buttons].each do |button|
              button[:type] ||= 'basic'
              haml_concat send("#{button[:type]}_button", button[:label], button[:action]) if button[:if] == true
            end
            if can? :edit, object
              haml_concat primary_button(t('modules.actions.defaults.edit', resource: klass), edit_polymorphic_path([parent,object]), icon: :pencil) unless options[:skip_edit]
            end
          end
        end
      end
      yield if block_given?
    end    
  end

  def display_flash
    capture_haml do
      haml_tag :div, class: 'flash' do
        haml_tag :ul do
          flash.each do |type, message|
            message_class = type
            haml_tag :li, message, class: "#{message_class}"
          end
        end
      end
    end
  end

end
