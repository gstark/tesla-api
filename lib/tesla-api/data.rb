module TeslaAPI
  class Data
    def method_missing(method_name, *args, &block)
      if has_query_ivar_method?(method_name)
        instance_variable_get(instance_var)
      else
        super(symbol, *args, &block)
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      has_query_ivar_method?(method_name) || super
    end

    def inspect
      "#<#{self.class.name}:0x#{self.object_id.to_s(16)} #{inspect_ivars}>"
    end

    def ivar_from_data(name, data_key, data)
      instance_variable_set("@#{name}".to_sym, data[data_key])

      self.class.send(:attr_reader, name.to_sym)
    end

    protected

    def has_query_ivar_method?(method_name)
      method = method_name.to_s
      instance_var = "@#{method.gsub(/\?$/,"")}".to_sym

      method =~ /(.+)\?/ && instance_variables.include?(instance_var)
    end

    def inspect_ivars
      ivars_for_inspect.map { |ivar| "#{ivar}=#{instance_variable_get(ivar)}" }.join(" ")
    end

    def ivars_for_inspect
      (instance_variables - [:@tesla])
    end
  end
end

