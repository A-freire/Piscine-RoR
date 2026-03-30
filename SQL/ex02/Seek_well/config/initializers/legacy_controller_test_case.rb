if Rails.env.test?
  module LegacyControllerTestCase
    def post(action, *args, **kwargs)
      if args.any? && kwargs.empty?
        super(action, params: args.first)
      else
        super
      end
    end
  end

  ActionController::TestCase.prepend(LegacyControllerTestCase)
end
