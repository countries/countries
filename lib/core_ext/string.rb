# encoding: utf-8
require 'active_support/multibyte'

class String
  def mb_chars
    ActiveSupport::Multibyte.proxy_class.new(self)
  end
end
