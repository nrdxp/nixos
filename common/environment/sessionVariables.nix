{ pkgs, ... }:
let
	fd_cmd = "fd -t f -H";
in
	{ # default editor
		EDITOR                      = "nvim";
		VISUAL                      = "nvim";
		# bat paging only works by setting this manually for some reason
		BAT_PAGER                   = "less";
		# set goroot
		GOROOT                      = [ "${pkgs.go}/share/go" ];
		# custome fzf commands
		FZF_ALT_C_COMMAND           =
			"while read line; do " +
			"line=\"'\${(Q)line}'\"; [[ -d \"'$line'\" ]] && echo \"'$line'\"; " +
			"done < $HOME/.cache/zsh-cdr/recent-dirs";
		FZF_DEFAULT_COMMAND         = fd_cmd;
		FZF_CTRL_T_COMMAND          = fd_cmd;
	}
