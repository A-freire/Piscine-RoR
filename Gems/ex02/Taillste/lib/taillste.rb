# frozen_string_literal: true

require_relative "taillste/version"

module Taillste
  class Drum
    def beat
      [1, 4, 9]
    end

    def shuffle
      beat.shuffle
    end

    def count
      (1..beat.max).map { |i| beat.include?(i) ? i.to_s : "." }.join("\n") + "\n"
    end

    def played_with
      "Both arms and legs"
    end
  end

  class Beat_box < Drum
    def beat
      [1, 5, 7]
    end

    def played_with
      "Mouth"
    end
  end

  class Clap < Drum
    def initialize
      @shuffle_toggle = false
    end

    def beat
      [2, 3, 7, 8]
    end

    def shuffle
      @shuffle_toggle = !@shuffle_toggle
      @shuffle_toggle ? [7, 2, 8, 3] : [3, 8, 2, 7]
    end

    def played_with
      "Both_hands"
    end
  end
end
