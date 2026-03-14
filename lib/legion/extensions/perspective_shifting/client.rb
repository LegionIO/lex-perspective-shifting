# frozen_string_literal: true

require 'legion/extensions/perspective_shifting/helpers/constants'
require 'legion/extensions/perspective_shifting/helpers/perspective'
require 'legion/extensions/perspective_shifting/helpers/perspective_view'
require 'legion/extensions/perspective_shifting/helpers/shifting_engine'
require 'legion/extensions/perspective_shifting/runners/perspective_shifting'

module Legion
  module Extensions
    module PerspectiveShifting
      class Client
        include Runners::PerspectiveShifting

        def initialize(**)
          @shifting_engine = Helpers::ShiftingEngine.new
        end

        private

        attr_reader :shifting_engine
      end
    end
  end
end
