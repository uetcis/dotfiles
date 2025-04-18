# if test (tty) = "/dev/tty2"
#   echo TTY2 Launching
# 	sudo /home/weitcis/.config/hypr/escalated.sh
#   # nmcli connection up "Google Fi" &
# 	exec dbus-launch --exit-with-session Hyprland
# end

# if test (tty) = "/dev/tty2"
#   echo TTY4 Launching
# 	# sudo /home/weitcis/.config/hypr/escalated.sh
#   # nmcli connection up "Google Fi" &
#   #	exec bash -c "dbus-launch --exit-with-session niri 2>&1 | sudo tee /dev/tty4"
#   # exec dbus-launch --exit-with-session niri

#   /home/weitcis/.config/hypr/audio.sh
#   set -x RUST_BACKTRACE full
#   exec dbus-launch --exit-with-session niri --session &> /home/weitcis/.config/niri/niri.log
# end

if status is-interactive
  set -x GPG_TTY (tty)
  starship init fish | source
  # thefuck --alias | source
  zoxide init fish | source
  direnv hook fish | source
  fzf_key_bindings
  alias vim nvim
  alias tp trash-put
  alias rm 'echo "This is not the command you are looking for."; false'
  alias cd z
  alias ls exa
end

function y
  set tmp (mktemp -t "yazi-cwd.XXXXXX")
  yazi $argv --cwd-file="$tmp"
  if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
    builtin cd -- "$cwd"
  end
  /bin/rm -f -- "$tmp"
end

function spawn
  niri msg action spawn -- $argv
end

function note
  set header_date (date +"%Y-%m-%d")
  set filename (date +"./content/notes/%m-%d-%y.md")
  cd ~/Code/blog/  
  echo "+++
title = \"$header_date\"
date = $header_date
page_template = \"blog-page.html\"
+++
" > $filename
  env $EDITOR $filename
end

function envelope
  set sample_addr (echo -e $SENDER_ADDR | string collect)

  set sender (mktemp)
  set receiver (mktemp)
  echo $sample_addr > $sender
  echo $sample_addr > $receiver
  env $EDITOR $sender
  env $EDITOR $receiver

  set output (mktemp)
  typst compile ~/Code/envelope/envelope.typ -f pdf \
    --input=sender=(cat $sender | string collect) \
    --input=receiver=(cat $receiver | string collect) \
    --input=extra=$argv $output
  open $output
  read -P "Confirm?" && lpr -o PageSize=Env10 $output || echo Cancelled
  /bin/rm $output $sender $receiver
end


  # BEGIN opam configuration
  # This is useful if you're using opam as it adds:
  #   - the correct directories to the PATH
  #   - auto-completion for the opam binary
  # This section can be safely removed at any time if needed.
  test -r '/home/weitcis/.opam/opam-init/init.fish' && source '/home/weitcis/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
  # END opam configuration
