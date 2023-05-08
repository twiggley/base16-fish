# base16-fish (https://github.com/tomyun/base16-fish)
# based on base16-shell (https://github.com/chriskempson/base16-shell)
# Catppuccin Macchiato scheme by Catppuccin Org (https://github.com/catppuccin)
# Referenced catppuccin/base16 (https://github.com/catppuccin/base16) and
# catppuccin/iterm (https://github.com/catppuccin/iterm) and
# catppuccin/fish (https://github.com/catppuccin/fish)

function base16-catppuccin-macchiato -d "Catppuccin Macchiato"
  set color00 24/27/3a # Base 00 - Black/Base
  set color01 ed/87/96 # Base 08 - Red
  set color02 a6/da/95 # Base 0B - Green
  set color03 ee/d4/9f # Base 0A - Yellow
  set color04 8a/ad/f4 # Base 0D - Blue
  set color05 c6/a0/f6 # Base 0E - Mauve
  set color06 8b/d5/ca # Base 0C - Teal
  set color07 ca/d3/f5 # Base 05 - White/Text
  set color08 49/4d/64 # Base 03 - Bright Black / Surface1
  set color09 $color01 # Base 08 - Bright Red
  set color10 $color02 # Base 0B - Bright Green
  set color11 $color03 # Base 0A - Bright Yellow
  set color12 $color04 # Base 0D - Bright Blue
  set color13 $color05 # Base 0E - Bright Mauve
  set color14 $color06 # Base 0C - Bright Teal
  set color15 b7/bd/f8 # Base 07 - Bright White / Lavendar
  set color16 f5/a9/7f # Base 09 - Peach
  set color17 f0/c6/c6 # Base 0F - Flamingo
  set color18 1e/20/30 # Base 01 - Mantle
  set color19 36/3a/4f # Base 02 - Surface0
  set color20 49/4d/64 # Base 04 - Surface2
  set color21 f4/db/d6 # Base 06 - Rosewater
  set colorfg $color07 # Base 05 - White/Text
  set colorbg $color00 # Base 00 - Black/Base

  if test -n "$TMUX"
    # Tell tmux to pass the escape sequences through
    # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
    function put_template; printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $argv; end;
    function put_template_var; printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $argv; end;
    function put_template_custom; printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $argv; end;
  else if string match 'screen*' $TERM # [ "${TERM%%[-.]*}" = "screen" ]
    # GNU screen (screen, screen-256color, screen-256color-bce)
    function put_template; printf '\033P\033]4;%d;rgb:%s\007\033\\' $argv; end;
    function put_template_var; printf '\033P\033]%d;rgb:%s\007\033\\' $argv; end;
    function put_template_custom; printf '\033P\033]%s%s\007\033\\' $argv; end;
  else if string match 'linux*' $TERM # [ "${TERM%%-*}" = "linux" ]
    function put_template; test $argv[1] -lt 16 && printf "\e]P%x%s" $argv[1] (echo $argv[2] | sed 's/\///g'); end;
    function put_template_var; true; end;
    function put_template_custom; true; end;
  else
    function put_template; printf '\033]4;%d;rgb:%s\033\\' $argv; end;
    function put_template_var; printf '\033]%d;rgb:%s\033\\' $argv; end;
    function put_template_custom; printf '\033]%s%s\033\\' $argv; end;
  end

  # 16 color space
  put_template 0  $color00
  put_template 1  $color01
  put_template 2  $color02
  put_template 3  $color03
  put_template 4  $color04
  put_template 5  $color05
  put_template 6  $color06
  put_template 7  $color07
  put_template 8  $color08
  put_template 9  $color09
  put_template 10 $color10
  put_template 11 $color11
  put_template 12 $color12
  put_template 13 $color13
  put_template 14 $color14
  put_template 15 $color15

  # 256 color space
  put_template 16 $color16
  put_template 17 $color17
  put_template 18 $color18
  put_template 19 $color19
  put_template 20 $color20
  put_template 21 $color21

  # foreground / background / cursor color
  if test -n "$ITERM_SESSION_ID"
    # iTerm2 proprietary escape codes
    put_template_custom Pg cad3f5 # foreground
    put_template_custom Ph 24273a # background
    put_template_custom Pi cad3f5 # bold color
    put_template_custom Pj 5b6078 # selection color
    put_template_custom Pk cad3f5 # selected text color
    put_template_custom Pl f4dbd6 # cursor
    put_template_custom Pm cad3f5 # cursor text
  else
    put_template_var 10 $colorfg
    if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]
      put_template_var 11 $colorbg
      if string match 'rxvt*' $TERM # [ "${TERM%%-*}" = "rxvt" ]
        put_template_var 708 $colorbg # internal border (rxvt)
      end
    end
    put_template_custom 12 ";7" # cursor (reverse video)
  end

  # set syntax highlighting colors
  # name: 'Catppuccin macchiato'
  # url: 'https://github.com/catppuccin/fish'
  # preferred_background: 24273a
  set -U fish_color_normal cad3f5
  set -U fish_color_command 8aadf4
  set -U fish_color_param f0c6c6
  set -U fish_color_keyword ed8796
  set -U fish_color_quote a6da95
  set -U fish_color_redirection f5bde6
  set -U fish_color_end f5a97f
  set -U fish_color_comment 8087a2
  set -U fish_color_error ed8796
  set -U fish_color_gray 6e738d
  set -U fish_color_selection --background=363a4f
  set -U fish_color_search_match --background=363a4f
  set -U fish_color_option a6da95
  set -U fish_color_operator f5bde6
  set -U fish_color_escape ee99a0
  set -U fish_color_autosuggestion 6e738d
  set -U fish_color_cancel ed8796
  set -U fish_color_cwd eed49f
  set -U fish_color_user 8bd5ca
  set -U fish_color_host 8aadf4
  set -U fish_color_host_remote a6da95
  set -U fish_color_status ed8796
  set -U fish_pager_color_progress 6e738d
  set -U fish_pager_color_prefix f5bde6
  set -U fish_pager_color_completion cad3f5
  set -U fish_pager_color_description 6e738d

  # remember current theme
  set -U base16_theme catppuccin-macchiato

  # clean up
  functions -e put_template put_template_var put_template_custom
end
