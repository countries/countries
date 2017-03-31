#!/bin/env ruby
# encoding: utf-8

module ISO3166
  module Emoji
    CODE_POINTS = {
      'a' => '🇦',
      'b' => '🇧',
      'c' => '🇨',
      'd' => '🇩',
      'e' => '🇪',
      'f' => '🇫',
      'g' => '🇬',
      'h' => '🇭',
      'i' => '🇮',
      'j' => '🇯',
      'k' => '🇰',
      'l' => '🇱',
      'm' => '🇲',
      'n' => '🇳',
      'o' => '🇴',
      'p' => '🇵',
      'q' => '🇶',
      'r' => '🇷',
      's' => '🇸',
      't' => '🇹',
      'u' => '🇺',
      'v' => '🇻',
      'w' => '🇼',
      'x' => '🇽',
      'y' => '🇾',
      'z' => '🇿'
    }.freeze

    def emoji_flag
      alpha2.downcase.chars.map { |c| CODE_POINTS[c] }.join('')
    end
  end
end
