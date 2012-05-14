def initialize(*args)
  super
  @action = :notify
end

actions :notify

attribute :key, :kind_of => String, :required => true
attribute :app, :kind_of => String, :required => true
