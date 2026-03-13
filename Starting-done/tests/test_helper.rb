# frozen_string_literal: true

require "minitest/autorun"
require "open3"
require "pathname"

ROOT = Pathname.new(__dir__).join("..").expand_path

def run_script(relative_path, *args)
  script_path = ROOT.join(relative_path).to_s
  Open3.capture3(script_path, *args.map(&:to_s))
end
