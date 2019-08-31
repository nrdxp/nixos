{ pkgs, ... }:
let
  inherit (pkgs) zsh;
in
''
  #!${zsh}/bin/zsh

  # simple script to give battery percentage in color in tmux status line
  # if no battery is present in the system then print level of available entropy

  readonly \
    RED='#[fg=#ff5c57]' \
    COLOR_OFF='#[fg=colour236]' \
    battery=$(echo /sys/class/power_supply/BAT<0-9>([1])) \
    entropy=$(</proc/sys/kernel/random/entropy_avail)

  if [[ -d $battery ]]; then
    readonly \
      full_capacity=$(< $battery/charge_full) \
      current_capacity=$(< $battery/charge_now) \
      charge_status=$(< $battery/status)

    readonly \
      charge_percentage=$(( $current_capacity.0 / $full_capacity.0 * 100 ))
  fi

  case $charge_status in
    Charging)
      printf "%s%s%d%%" "⚡" "$COLOR_OFF" "$charge_percentage"
      ;;
    Discharging)
      printf "%s%s%d%%" "$RED🔋" "$COLOR_OFF" "$charge_percentage"
      ;;
    Unknown|Full)
      printf "%s%d%%" "$COLOR_OFF" "$charge_percentage"
      ;;
    *)
    printf "%s%s" "$COLOR_OFF" "$entropy"
  esac
''
