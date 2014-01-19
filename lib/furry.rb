require 'active_support/core_ext/module/delegation'
require 'active_support/core_ext/string'
require 'active_support/hash_with_indifferent_access'
require 'cgi'
require 'erb'

require 'furry/version'

module Furry
  autoload :App,        'furry/app'
  autoload :Route,      'furry/route'
  autoload :Router,     'furry/router'
  autoload :UrlHelpers, 'furry/url_helpers'
  autoload :Controller, 'furry/controller'
  autoload :Container,  'furry/container'
end
