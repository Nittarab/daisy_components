# frozen_string_literal: true

module DaisyComponents
  module IconsHelper
    def hamburger_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M4 6h16M4 12h16M4 18h16')
      end
    end

    def close_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M6 18L18 6M6 6l12 12')
      end
    end

    def volume_on_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M15.536 8.464a5 5 0 010 7.072M12 6v12m0 0l-4-4m4 4l4-4')
      end
    end

    def volume_off_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        path = 'M5.586 15H4a1 1 0 01-1-1v-4a1 1 0 011-1h1.586l4.707-4.707C10.923 3.663 12 4.109 12 5v14c0 ' \
               '.891-1.077 1.337-1.707.707L5.586 15z'
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: path)
      end
    end

    def sun_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        path = 'M12 3v1m0 16v1m9-9h-1M4 12H3m15.364 6.364l-.707-.707M6.343 6.343l-.707-.707m12.728 0l-' \
               '.707.707M6.343 17.657l-.707.707M16 12a4 4 0 11-8 0 4 4 0 018 0z'
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: path)
      end
    end

    def moon_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        path = 'M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z'
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: path)
      end
    end

    def warning_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        path = 'M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-' \
               '1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z'
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2', d: path)
      end
    end

    def chevron_down_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M19 9l-7 7-7-7')
      end
    end

    def check_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round', stroke_width: '2',
                 d: 'M5 13l4 4L19 7')
      end
    end

    def heart_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', fill: 'none', viewBox: '0 0 24 24',
              'stroke-width': '2.5', stroke: 'currentColor', class: size_class) do
        tag.path('stroke-linecap': 'round', 'stroke-linejoin': 'round',
                 d: 'M21 8.25c0-2.485-2.099-4.5-4.688-4.5-1.935 0-3.597 1.126-4.312 2.733-.715-1.607-2.377-2.733-4.313-2.733C5.1 3.75 3 5.765 3 8.25c0 7.22 9 12 9 12s9-4.78 9-12Z')
      end
    end

    def home_icon(size_class)
      tag.svg(xmlns: 'http://www.w3.org/2000/svg', class: size_class, fill: 'none',
              viewBox: '0 0 24 24', stroke: 'currentColor', stroke_width: '2.5') do
        tag.path(stroke_linecap: 'round', stroke_linejoin: 'round',
                 d: 'M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25')
      end
    end

    def email_icon(size_class)
      tag.svg(aria_label: 'Email icon', class: size_class, xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 24 24') do
        tag.g(stroke_linejoin: 'round', stroke_linecap: 'round', stroke_width: '2', fill: 'none', stroke: 'black') do
          safe_join([
                      tag.rect(width: '20', height: '16', x: '2', y: '4', rx: '2'),
                      tag.path(d: 'm22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7')
                    ])
        end
      end
    end

    def github_icon(size_class)
      tag.svg(aria_label: 'GitHub logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 24 24') do
        tag.path(fill: 'white',
                 d: 'M12,2A10,10 0 0,0 2,12C2,16.42 4.87,20.17 8.84,21.5C9.34,21.58 9.5,21.27 9.5,21C9.5,20.77 9.5,20.14 9.5,19.31C6.73,19.91 6.14,17.97 6.14,17.97C5.68,16.81 5.03,16.5 5.03,16.5C4.12,15.88 5.1,15.9 5.1,15.9C6.1,15.97 6.63,16.93 6.63,16.93C7.5,18.45 8.97,18 9.54,17.76C9.63,17.11 9.89,16.67 10.17,16.42C7.95,16.17 5.62,15.31 5.62,11.5C5.62,10.39 6,9.5 6.65,8.79C6.55,8.54 6.2,7.5 6.75,6.15C6.75,6.15 7.59,5.88 9.5,7.17C10.29,6.95 11.15,6.84 12,6.84C12.85,6.84 13.71,6.95 14.5,7.17C16.41,5.88 17.25,6.15 17.25,6.15C17.8,7.5 17.45,8.54 17.35,8.79C18,9.5 18.38,10.39 18.38,11.5C18.38,15.32 16.04,16.16 13.81,16.41C14.17,16.72 14.5,17.33 14.5,18.26C14.5,19.6 14.5,20.68 14.5,21C14.5,21.27 14.66,21.59 15.17,21.5C19.14,20.16 22,16.42 22,12A10,10 0 0,0 12,2Z')
      end
    end

    def google_icon(size_class)
      tag.svg(aria_label: 'Google logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 512 512') do
        tag.g do
          safe_join([
                      tag.path(d: 'm0 0H512V512H0', fill: '#fff'),
                      tag.path(fill: '#34a853', d: 'M153 292c30 82 118 95 171 60h62v48A192 192 0 0190 341'),
                      tag.path(fill: '#4285f4', d: 'm386 400a140 175 0 0053-179H260v74h102q-7 37-38 57'),
                      tag.path(fill: '#fbbc02', d: 'm90 341a208 200 0 010-171l63 49q-12 37 0 73'),
                      tag.path(fill: '#ea4335', d: 'm153 219c22-69 116-109 179-50l55-54c-78-75-230-72-297 55')
                    ])
        end
      end
    end

    def facebook_icon(size_class)
      tag.svg(aria_label: 'Facebook logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 32 32') do
        tag.path(fill: 'white', d: 'M8 12h5V8c0-6 4-7 11-6v5c-4 0-5 0-5 3v2h5l-1 6h-4v12h-6V18H8z')
      end
    end

    def x_icon(size_class)
      tag.svg(aria_label: 'X logo', class: size_class, viewBox: '0 0 300 271', xmlns: 'http://www.w3.org/2000/svg') do
        tag.path(fill: 'currentColor',
                 d: 'm236 0h46l-101 115 118 156h-92.6l-72.5-94.8-83 94.8h-46l107-123-113-148h94.9l65.5 86.6zm-16.1 244h25.5l-165-218h-27.4z')
      end
    end

    def kakao_icon(size_class)
      tag.svg(aria_label: 'Kakao logo', class: size_class, viewBox: '0 0 512 512',
              xmlns: 'http://www.w3.org/2000/svg') do
        tag.path(fill: '#181600',
                 d: 'M255.5 48C299.345 48 339.897 56.5332 377.156 73.5996C414.415 90.666 443.871 113.873 465.522 143.22C487.174 172.566 498 204.577 498 239.252C498 273.926 487.174 305.982 465.522 335.42C443.871 364.857 414.46 388.109 377.291 405.175C340.122 422.241 299.525 430.775 255.5 430.775C241.607 430.775 227.262 429.781 212.467 427.795C148.233 472.402 114.042 494.977 109.892 495.518C107.907 496.241 106.012 496.15 104.208 495.248C103.486 494.706 102.945 493.983 102.584 493.08C102.223 492.177 102.043 491.365 102.043 490.642V489.559C103.126 482.515 111.335 453.169 126.672 401.518C91.8486 384.181 64.1974 361.2 43.7185 332.575C23.2395 303.951 13 272.843 13 239.252C13 204.577 23.8259 172.566 45.4777 143.22C67.1295 113.873 96.5849 90.666 133.844 73.5996C171.103 56.5332 211.655 48 255.5 48Z')
      end
    end

    def apple_icon(size_class)
      tag.svg(aria_label: 'Apple logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 1195 1195') do
        tag.path(fill: 'white',
                 d: 'M1006.933 812.8c-32 153.6-115.2 211.2-147.2 249.6-32 25.6-121.6 25.6-153.6 6.4-38.4-25.6-134.4-25.6-166.4 0-44.8 32-115.2 19.2-128 12.8-256-179.2-352-716.8 12.8-774.4 64-12.8 134.4 32 134.4 32 51.2 25.6 70.4 12.8 115.2-6.4 96-44.8 243.2-44.8 313.6 76.8-147.2 96-153.6 294.4 19.2 403.2zM802.133 64c12.8 70.4-64 224-204.8 230.4-12.8-38.4 32-217.6 204.8-230.4z')
      end
    end

    def amazon_icon(size_class)
      tag.svg(aria_label: 'Amazon logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 16 16') do
        tag.g(fill: 'black') do
          safe_join([
                      tag.path(d: 'M14.463 13.831c-1.753 1.294-4.291 1.981-6.478 1.981-3.066 0-5.825-1.131-7.912-3.019-.163-.147-.019-.35.178-.234 2.253 1.313 5.041 2.1 7.919 2.1 1.941 0 4.075-.403 6.041-1.238.294-.125.544.197.253.409z'),
                      tag.path(d: 'M15.191 13c-.225-.287-1.481-.137-2.047-.069-.172.019-.197-.128-.044-.238 1.003-.703 2.647-.5 2.838-.266.194.238-.05 1.884-.991 2.672-.144.122-.281.056-.219-.103.216-.528.688-1.709.463-1.997zM11.053 11.838l.003.003c.387-.341 1.084-.95 1.478-1.278.156-.125.128-.334.006-.509-.353-.488-.728-.884-.728-1.784v-3c0-1.272.088-2.438-.847-3.313-.738-.706-1.963-.956-2.9-.956-1.831 0-3.875.684-4.303 2.947-.047.241.131.369.287.403l1.866.203c.175-.009.3-.181.334-.356.159-.778.813-1.156 1.547-1.156.397 0 .847.144 1.081.5.269.397.234.938.234 1.397v.25c-1.116.125-2.575.206-3.619.666-1.206.522-2.053 1.584-2.053 3.147 0 2 1.259 3 2.881 3 1.369 0 2.116-.322 3.172-1.403.35.506.463.753 1.103 1.284a.395.395 0 0 0 .456-.044zm-1.94-4.694c0 .75.019 1.375-.359 2.041-.306.544-.791.875-1.331.875-.737 0-1.169-.563-1.169-1.394 0-1.641 1.472-1.938 2.863-1.938v.416z')
                    ])
        end
      end
    end

    def microsoft_icon(size_class)
      tag.svg(aria_label: 'Microsoft logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 512 512') do
        safe_join([
                    tag.path(d: 'M96 96H247V247H96', fill: '#f24f23'),
                    tag.path(d: 'M265 96V247H416V96', fill: '#7eba03'),
                    tag.path(d: 'M96 265H247V416H96', fill: '#3ca4ef'),
                    tag.path(d: 'M265 265H416V416H265', fill: '#f9ba00')
                  ])
      end
    end

    def line_icon(size_class)
      tag.svg(aria_label: 'Line logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg', viewBox: '0 0 16 16') do
        tag.g(fill_rule: 'evenodd', stroke_linejoin: 'round', fill: 'white') do
          tag.path(fill_rule: 'nonzero',
                   d: 'M12.91 6.57c.232 0 .42.19.42.42 0 .23-.188.42-.42.42h-1.17v.75h1.17a.42.42 0 1 1 0 .84h-1.59a.42.42 0 0 1-.418-.42V5.4c0-.23.188-.42.42-.42h1.59a.42.42 0 0 1-.002.84h-1.17v.75h1.17zm-2.57 2.01a.421.421 0 0 1-.757.251l-1.63-2.217V8.58a.42.42 0 0 1-.42.42.42.42 0 0 1-.418-.42V5.4a.418.418 0 0 1 .755-.249L9.5 7.366V5.4c0-.23.188-.42.42-.42.23 0 .42.19.42.42v3.18zm-3.828 0c0 .23-.188.42-.42.42a.42.42 0 0 1-.418-.42V5.4c0-.23.188-.42.42-.42.23 0 .418.19.418.42v3.18zM4.868 9h-1.59c-.23 0-.42-.19-.42-.42V5.4c0-.23.19-.42.42-.42.232 0 .42.19.42.42v2.76h1.17a.42.42 0 1 1 0 .84M16 6.87C16 3.29 12.41.376 8 .376S0 3.29 0 6.87c0 3.208 2.846 5.896 6.69 6.405.26.056.615.172.705.394.08.2.053.518.026.722 0 0-.092.565-.113.685-.035.203-.16.79.693.432.854-.36 4.607-2.714 6.285-4.646C15.445 9.594 16 8.302 16 6.87')
        end
      end
    end

    def metamask_icon(size_class)
      tag.svg(aria_label: 'MetaMask logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 507.83 470.86') do
        tag.defs do
          tag.style('.b{fill:#e4761b;stroke:#e4761b}.c{fill:#d7c1b3;stroke:#d7c1b3}.d{fill:#233447;stroke:#233447}.e{fill:#cd6116;stroke:#cd6116}.f{fill:#e4751f;stroke:#e4751f}.g{fill:#f6851b;stroke:#f6851b}.j{fill:#763d16;stroke:#763d16}.b,.c,.d,.e,.f,.g,.j{stroke-linecap:round;stroke-linejoin:round}')
        end
        safe_join([
                    tag.path(d: 'M482.09.5 284.32 147.38l36.58-86.66z',
                             style: 'fill:#e2761b;stroke:#e2761b;stroke-linecap:round;stroke-linejoin:round'),
                    tag.path(
                      d: 'm25.54.5 196.18 148.27-34.79-88.05zM410.93 340.97l-52.67 80.7 112.7 31 32.4-109.91zM4.67 342.76l32.2 109.91 112.7-31-52.67-80.7z', class: 'b'
                    ),
                    tag.path(
                      d: 'm143.21 204.62-31.41 47.51 111.9 4.97-3.97-120.25zM364.42 204.62l-77.51-69.16-2.59 121.64 111.71-4.97zM149.57 421.67l67.18-32.8-58.04-45.32zM290.88 388.87l67.38 32.8-9.34-78.12z', class: 'b'
                    ),
                    tag.path(d: 'm358.26 421.67-67.38-32.8 5.37 43.93-.6 18.48zM149.57 421.67l62.61 29.61-.4-18.48 4.97-43.93z',
                             class: 'c'),
                    tag.path(d: 'm213.17 314.54-56.05-16.5 39.55-18.09zM294.46 314.54l16.5-34.59 39.75 18.09z',
                             class: 'd'),
                    tag.path(
                      d: 'm149.57 421.67 9.54-80.7-62.21 1.79zM348.72 340.97l9.54 80.7 52.67-78.91zM396.03 252.13l-111.71 4.97 10.34 57.44 16.5-34.59 39.75 18.09zM157.12 298.04l39.75-18.09 16.3 34.59 10.53-57.44-111.9-4.97z', class: 'e'
                    ),
                    tag.path(
                      d: 'm111.8 252.13 46.91 91.42-1.59-45.51zM350.91 298.04l-1.99 45.51 47.11-91.42zM223.7 257.1l-10.53 57.44 13.12 67.77 2.98-89.24zM284.32 257.1l-5.36 35.77 2.38 89.44 13.32-67.77z', class: 'f'
                    ),
                    tag.path(
                      d: 'm294.66 314.54-13.32 67.77 9.54 6.56 58.04-45.32 1.99-45.51zM157.12 298.04l1.59 45.51 58.04 45.32 9.54-6.56-13.12-67.77z', class: 'g'
                    ),
                    tag.path(
                      d: 'M295.65 451.28l.6-18.48-4.97-4.38h-74.93l-4.57 4.38.4 18.48-62.61-29.61 21.86 17.88 44.32 30.81h76.13l44.52-30.81 21.86-17.88z', style: 'stroke-linecap:round;stroke-linejoin:round;fill:#c0ad9e;stroke:#c0ad9e'
                    ),
                    tag.path(d: 'm290.88 388.87-9.54-6.56h-55.05l-9.54 6.56-4.97 43.93 4.57-4.38h74.93l4.97 4.38z',
                             style: 'stroke-linecap:round;stroke-linejoin:round;fill:#161616;stroke:#161616'),
                    tag.path(
                      d: 'M490.44 156.92l16.89-81.09L482.09.5 290.88 142.41l73.54 62.21 103.95 30.41 23.06-26.83-9.94-7.15 15.9-14.51-12.32-9.54 15.9-12.13zM.5 75.83l16.89 81.09-10.73 7.95L22.56 177l-12.12 9.54 15.9 14.51-9.94 7.15 22.86 26.83 103.95-30.41 73.54-62.21L25.54.5z', class: 'j'
                    ),
                    tag.path(
                      d: 'm468.37 235.03-103.95-30.41 31.61 47.51-47.11 91.42 62.01-.79h92.43zM143.21 204.62 39.26 235.03 4.67 342.76H96.9l61.81.79-46.91-91.42zM284.32 257.1l6.56-114.69 30.22-81.69H186.93l29.82 81.69 6.95 114.69 2.39 36.17.2 89.04h55.05l.4-89.04z', class: 'g'
                    )
                  ])
      end
    end

    def slack_icon(size_class)
      tag.svg(aria_label: 'Slack logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 512 512') do
        tag.g(stroke_linecap: 'round', stroke_width: '78') do
          safe_join([
                      tag.path(stroke: '#36c5f0', d: 'm110 207h97m0-97h.1v-.1'),
                      tag.path(stroke: '#2eb67d', d: 'm305 110v97m97 0v.1h.1'),
                      tag.path(stroke: '#ecb22e', d: 'm402 305h-97m0 97h-.1v.1'),
                      tag.path(stroke: '#e01e5a', d: 'M110 305h.1v.1m97 0v97')
                    ])
        end
      end
    end

    def linkedin_icon(size_class)
      tag.svg(aria_label: 'LinkedIn logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 32 32') do
        tag.path(fill: 'white', fill_rule: 'evenodd',
                 d: 'M26.111,3H5.889c-1.595,0-2.889,1.293-2.889,2.889V26.111c0,1.595,1.293,2.889,2.889,2.889H26.111c1.595,0,2.889-1.293,2.889-2.889V5.889c0-1.595-1.293-2.889-2.889-2.889ZM10.861,25.389h-3.877V12.87h3.877v12.519Zm-1.957-14.158c-1.267,0-2.293-1.034-2.293-2.31s1.026-2.31,2.293-2.31,2.292,1.034,2.292,2.31-1.026,2.31-2.292,2.31Zm16.485,14.158h-3.858v-6.571c0-1.802-.685-2.809-2.111-2.809-1.551,0-2.362,1.048-2.362,2.809v6.571h-3.718V12.87h3.718v1.686s1.118-2.069,3.775-2.069,4.556,1.621,4.556,4.975v7.926Z')
      end
    end

    def vk_icon(size_class)
      tag.svg(aria_label: 'VK logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 2240 2240') do
        tag.g(fill: 'white') do
          tag.path(d: 'M2077 904q23 64-150 294-24 32-65 85-78 100-90 131-17 41 14 81 17 21 81 82h1l1 1 1 1 2 2q141 131 191 221 3 5 6.5 12.5t7 26.5-.5 34-25 27.5-59 12.5l-256 4q-24 5-56-5t-52-22l-20-12q-30-21-70-64t-68.5-77.5-61-58-56.5-15.5q-3 1-8 3.5t-17 14.5-21.5 29.5-17 52-6.5 77.5q0 15-3.5 27.5t-7.5 18.5l-4 5q-18 19-53 22h-115q-71 4-146-16.5t-131.5-53-103-66T648 1722l-25-24q-10-10-27.5-30t-71.5-91-106-151-122.5-211T165 943q-6-16-6-27t3-16l4-6q15-19 57-19l274-2q12 2 23 6.5t16 8.5l5 3q16 11 24 32 20 50 46 103.5t41 81.5l16 29q29 60 56 104t48.5 68.5T814 1348t34 14 27-5q2-1 5-5t12-22 13.5-47 9.5-81 0-125q-2-40-9-73t-14-46l-6-12q-25-34-85-43-13-2 5-24 17-19 38-30 53-26 239-24 82 1 135 13 20 5 33.5 13.5t20.5 24 10.5 32 3.5 45.5-1 55-2.5 70.5-1.5 82.5q0 11-1 42t-.5 48 3.5 40.5 11.5 39 22.5 24.5q8 2 17 4t26-11 38-34.5 52-67 68-107.5q60-104 107-225 4-10 10-17.5t11-10.5l4-3 5-2.5 13-3 20-.5 288-2q39-5 64 2.5t31 16.5z')
        end
      end
    end

    def wechat_icon(size_class)
      tag.svg(aria_label: 'WeChat logo', class: size_class, xmlns: 'http://www.w3.org/2000/svg',
              viewBox: '0 0 32 32') do
        tag.g(fill: 'white') do
          safe_join([
                      tag.path(d: 'M11.606,3.068C5.031,3.068,0,7.529,0,12.393s4.344,7.681,4.344,7.681l-.706,2.676c-.093,.353,.284,.644,.602,.464l3.173-1.798c1.403,.447,4.381,.59,4.671,.603-.208-.721-.311-1.432-.311-2.095,0-3.754,3.268-9.04,10.532-9.04,.165,0,.331,.004,.496,.011-.965-4.627-5.769-7.827-11.195-7.827Zm-4.327,7.748c-.797,0-1.442-.646-1.442-1.442s.646-1.442,1.442-1.442,1.442,.646,1.442,1.442-.646,1.442-1.442,1.442Zm8.386,0c-.797,0-1.442-.646-1.442-1.442s.646-1.442,1.442-1.442,1.442,.646,1.442,1.442-.646,1.442-1.442,1.442Z'),
                      tag.path(d: 'M32,19.336c0-4.26-4.998-7.379-9.694-7.379-6.642,0-9.459,4.797-9.459,7.966s2.818,7.966,9.459,7.966c1.469,0,2.762-.211,3.886-.584l2.498,1.585c.197,.125,.447-.052,.394-.279l-.567-2.46c2.36-1.643,3.483-4.234,3.483-6.815Zm-12.73-.81c-.704,0-1.275-.571-1.275-1.275s.571-1.275,1.275-1.275,1.275,.571,1.275,1.275c0,.705-.571,1.275-1.275,1.275Zm6.373,0c-.704,0-1.275-.571-1.275-1.275s.571-1.275,1.275-1.275,1.275,.571,1.275,1.275-.571,1.275-1.275,1.275Z')
                    ])
        end
      end
    end
  end
end
