module ActiveRecord
  module ConnectionAdapters # :nodoc:
    module QueryCache
      def cache_sql_with_superquerycache(*args, &block)
        if Rails.cache.read(:ar_supercache)
          sql_exp = Rails.cache.fetch(:sql_exp) { {} }
          unless sql_exp.has_key?(args[0])
            sql_exp[args[0]] = false
            Rails.cache.write(:sql_exp,sql_exp)
          end
          if sql_exp.select { |k,v| v == true }.include?(args[0])
            request_without_superquerycache(*args, &block)
          else
            sub_key = args[1].collect{|a| "#{a.try(:name)} #{a.try(:value)}"}
            Rails.cache.fetch(Digest::SHA1.hexdigest("supercache_#{args[0]}_#{sub_key}")) do
              request_without_superquerycache(*args, &block)
            end
          end
        else
          request_without_superquerycache(*args, &block)
        end
      end

      alias_method :request_without_superquerycache, :cache_sql
      alias_method :cache_sql, :cache_sql_with_superquerycache

    end
  end
end

ActiveSupport::Notifications.subscribe "start_processing.action_controller" do |*args|
  event_controller = ActiveSupport::Notifications::Event.new *args
  if event_controller.payload[:controller] != "Supercache::DashboardController"
    if Rails.cache.read(:previous_controller) && Rails.cache.read(:previous_controller) !=  event_controller.payload[:controller]
      Rails.cache.write(:sql_exp,{})
      Rails.cache.write(:http_exp,{})
    end
    Rails.cache.write(:previous_controller, event_controller.payload[:controller])
  end
end