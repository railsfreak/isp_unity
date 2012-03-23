class SystemCall
  class << self
    def execute(commands=[])
      begin
        if commands.is_a?(Array)
          commands.each {|cmd| `#{cmd}`} 
        else
          `#{commands}`
        end
        return true
      rescue Exception => e
        IspUnityLog.debug("#{e}")
        IspUnityLog.error(I18n.t('system_call.execute.error'))
        IspUnityException.new(I18n.t('system_call.execute.error'))
      end
    end

    def get_ip(interface)
      begin
        result = `/sbin/ifconfig #{interface}`
        ip = /inet addr:(?<ip>(\d+[.]){3}\d+)/.match(result)
        ip = ip[0].split(':')[1] if ip
      rescue Exception => e
        IspUnityLog.debug("#{e}")
        IspUnityLog.error(I18n.t('system_call.execute.error'))
        IspUnityException.new(I18n.t('system_call.execute.error'))
      end
    end

#    def get_ip(interface)
#      begin
#        result = SystemCall.execute("/sbin/ifconfig #{interface}")
#        ip = /inet addr:(?<ip>(\d+[.]){3}\d+)/.match(result)
#        ip = ip[0].split(':')[1] if ip
#      rescue Exception => e
#        IspUnityLog.debug("#{e}")
#        IspUnityLog.error(I18n.t('system_call.execute.error'))
#        IspUnityException.new(I18n.t('system_call.execute.error'))
#      end
#    end
#  end
#  
  class IspUnityException < Exception
    def initialize(message)
      message = message['error'] if message.class == Hash
      super "[IspUnity] #{message}"
    end
  end

end
