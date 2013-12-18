require 'singleton'

class HaproxyConfig
  include Singleton

  def sections
    @sections ||= []
  end

  def reset
    sections.clear
  end

  def to_s
    sections.map(&:to_s).join("\n\n") << "\n"
  end
end
