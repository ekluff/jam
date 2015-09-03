# == Paperclip without ActiveRecord
#
# Original: https://gist.github.com/basgys/5712426

require 'active_model/naming'
require 'active_model/callbacks'
require 'active_model/validations'
require 'paperclip'

module Simplepaperclip
  def self.included(base)
    base.extend ActiveModel::Naming
    base.extend ActiveModel::Callbacks

    base.send :include, ActiveModel::Validations
    base.send :include, Paperclip::Glue

    # Paperclip required callbacks
    base.define_model_callbacks :save, only: [:after]
    base.define_model_callbacks :destroy, only: [:before, :after]
  end

  # ActiveModel requirements
  def to_model
    self
  end

  def valid?()      true end
  def new_record?() true end
  def destroyed?()  true end

  def errors
    obj = Object.new
    def obj.[](key)         [] end
    def obj.full_messages() [] end
    def obj.any?()       false end
    obj
  end
end
