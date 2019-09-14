function cleanup () {
  rm /run/user/$UID/swayidle.pid;
}

# clean up pid file if exiting for ANY reason
trap cleanup EXIT

(echo $$ > /run/user/$UID/swayidle.pid; exec swayidle -w \
  timeout 300 'swaylock -f -c 000000' \
  timeout 600 'swaymsg "output * dpms off"' \
  resume 'swaymsg "output * dpms on"' \
  before-sleep 'swaylock -f -c 000000')

cleanup
