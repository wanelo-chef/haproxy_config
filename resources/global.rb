
actions :create
default_action :create

attribute :name, kind_of: [String, NilClass], default: nil
attribute :maxconn, kind_of: [Integer, NilClass], default: nil
attribute :nbproc, kind_of: [Integer, NilClass], default: nil
attribute :spread_checks, kind_of: [Integer, NilClass], default: nil
attribute :user, kind_of: [String, NilClass], default: nil
attribute :group, kind_of: [String, NilClass], default: nil
