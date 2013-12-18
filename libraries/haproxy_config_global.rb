class HaproxyConfigGlobal
  attr_accessor :group, :maxconn, :nbproc, :spread_checks, :user

  def update_with_resource(resource)
    self.maxconn = resource.maxconn
    self.nbproc = resource.nbproc
    self.spread_checks = resource.spread_checks
    self.group = resource.group
    self.user = resource.user
  end

  def to_s
    ["global", configuration].join("\n")
  end

  def configuration
    config = []
    config << "maxconn #{self.maxconn}" if self.maxconn
    config << "nbproc #{self.nbproc}" if self.nbproc
    config << "spread-checks #{self.spread_checks}" if self.spread_checks
    config << "user '#{self.user}'" if self.user
    config << "group '#{self.group}'" if self.group

    config.map { |c| "  #{c}\n"}.join("\n")
  end
end
