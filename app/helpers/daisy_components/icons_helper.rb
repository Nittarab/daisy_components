# frozen_string_literal: true

module DaisyComponents
  module IconsHelper
    def hamburger_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M4 6h16M4 12h16M4 18h16')
      end
    end

    def close_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M6 18L18 6M6 6l12 12')
      end
    end

    def volume_on_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M15.536 8.464a5 5 0 010 7.072M12 6v12m0 0l-4-4m4 4l4-4')
      end
    end

    def volume_off_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        path = 'M5.586 15H4a1 1 0 01-1-1v-4a1 1 0 011-1h1.586l4.707-4.707C10.923 3.663 12 4.109 12 5v14c0 ' \
               '.891-1.077 1.337-1.707.707L5.586 15z'
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: path)
      end
    end

    def sun_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        path = 'M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-' \
               '.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z'
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: path)
      end
    end

    def moon_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z')
      end
    end
  end
end
