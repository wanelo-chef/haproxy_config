class HaproxyConfigDefaults
  attr_accessor :balance, :mode, :retries
  attr_accessor :timeout_client, :timeout_server, :timeout_connect

  def update_with_resource(resource)
    self.balance = resource.balance
    self.mode = resource.mode
    self.retries = resource.retries
    self.timeout_client = resource.timeout_client
    self.timeout_server = resource.timeout_server
    self.timeout_connect = resource.timeout_connect
  end

  def to_s
    ["defaults", configuration].join("\n")
  end

  def configuration
    config = []
    config << "balance #{self.balance}" if self.balance
    config << "mode #{self.mode}" if self.mode
    config << "retries #{self.retries}" if self.retries
    config << "timeout client #{self.timeout_client}" if self.timeout_client
    config << "timeout server #{self.timeout_server}" if self.timeout_server
    config << "timeout connect #{self.timeout_connect}" if self.timeout_connect

    config.map { |c| "  #{c}\n"}.join("\n")
  end
end
