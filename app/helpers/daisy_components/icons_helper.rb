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

    def heart_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z')
      end
    end

    def share_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none', viewBox: '0 0 24 24',
              stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M8.684 13.342C8.886 12.938 9 12.482 9 12c0-.482-.114-.938-.316-1.342m0 2.684a3 3 0 110-2.684m0 2.684l6.632 3.316m-6.632-6l6.632-3.316m0 0a3 3 0 105.367-2.684 3 3 0 00-5.367 2.684zm0 9.316a3 3 0 105.368 2.684 3 3 0 00-5.368-2.684z')
      end
    end
  end
end
