def set_flash_message(key, kind, options={}) #:nodoc:
        options[:scope] = "devise.#{controller_name}"
        options[:default] = Array(options[:default]).unshift(kind.to_sym)
        options[:resource_name] = resource_name
        message = I18n.t("#{resource_name}.#{kind}", options)
        flash[key] = message if message.present?
      end