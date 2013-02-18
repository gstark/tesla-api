module TeslaAPI
  # Base class for all data responses from the HTTP API
  #
  # Defines an instance_variable? method for each instance_variable defined allowing for
  # methods such as __________?
  #
  # Also overrides #inspect to elimiante the back reference to the connection object
  class Data
    def method_missing(method_name, *args, &block) # :nodoc:
      if has_query_ivar_method?(method_name)
        instance_variable_get(ivar_for_method_name(method_name))
      else
        super(symbol, *args, &block)
      end
    end

    def respond_to_missing?(method_name, include_private = false) # :nodoc:
      has_query_ivar_method?(method_name) || super
    end

    def inspect # :nodoc:
      "#<#{self.class.name}:0x#{self.object_id.to_s(16)} #{inspect_ivars}>"
    end

    def ivar_from_data(name, data_key, data) # :nodoc:
      instance_variable_set("@#{name}".to_sym, data[data_key])

      self.class.send(:attr_reader, name.to_sym)
    end

    protected

    def ivar_for_method_name(method_name) # :nodoc:
      "@#{method_name.to_s.gsub(/\?$/,"")}".to_sym
    end

    def has_query_ivar_method?(method_name) # :nodoc:
      method = method_name.to_s

      method =~ /(.+)\?/ && instance_variables.include?(ivar_for_method_name(method_name))
    end

    def inspect_ivars # :nodoc:
      ivars_for_inspect.map { |ivar| "#{ivar}=#{instance_variable_get(ivar)}" }.join(" ")
    end

    def ivars_for_inspect # :nodoc:
      (instance_variables - [:@tesla])
    end
  end
end

