#───────────────────────────────────────────────────────────────────────────────
# Load the shell dotfiles:
#     → ~/.aliases is for shell aliases
#     → ~/.functions is for shell functions
#     → ~/.behaviour is for customising how the shell behaves
#     → ~/.appearance is for customising how the shell looks
#───────────────────────────────────────────────────────────────────────────────
for file in ~/.{aliases,functions,behaviour,appearance}; do
	[ -r "$file" ] && . "$file"
done
unset file


# vim:ft=sh
