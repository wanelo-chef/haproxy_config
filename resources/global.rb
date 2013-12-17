
actions :create
default_action :create

attribute :name, kind_of: [String, NilClass], default: nil
attribute :maxconn, kind_of: [Integer, NilClass], default: nil
