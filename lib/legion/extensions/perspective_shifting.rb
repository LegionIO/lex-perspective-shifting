# frozen_string_literal: true

require 'legion/extensions/perspective_shifting/version'
require 'legion/extensions/perspective_shifting/helpers/constants'
require 'legion/extensions/perspective_shifting/helpers/perspective'
require 'legion/extensions/perspective_shifting/helpers/perspective_view'
require 'legion/extensions/perspective_shifting/helpers/shifting_engine'
require 'legion/extensions/perspective_shifting/runners/perspective_shifting'

module Legion
  module Extensions
    module PerspectiveShifting
      extend Legion::Extensions::Core if Legion::Extensions.const_defined? :Core
    end
  end
end
