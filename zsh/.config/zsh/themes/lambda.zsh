setopt prompt_subst
local ret_status="%(?.%F{#458588}%B❯%b%f.%F{#cc241d}%B❯%b%f)"
PROMPT='%F{#8ec07c}%~%f $(git_prompt_info)${ret_status} '
ZSH_THEME_GIT_PROMPT_PREFIX="%F{#d3869b}(%f%F{#b16286}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="%F{#d3869b}) %f%F{#d79921}✗%f "
ZSH_THEME_GIT_PROMPT_CLEAN="%F{#d3869b}) " 
