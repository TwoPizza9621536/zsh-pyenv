# SPDX-License-Identifier: MIT

# This plugin loads pyenv into the current shell and provides prompt info via
# the 'pyenv_prompt_info' function. Also loads pyenv-virtualenv if available.
# But do not warn the user if it is not a interactive shell. Basing this on
# rbenv and jenv plugins.
if ! command -v pyenv &>/dev/null; then
  FOUND_PYENV=0
elif [[ "${commands[pyenv]}" = */pyenv-win/* && "$(uname -r)" = *icrosoft* ]]; then
  FOUND_PYENV=0
else
  FOUND_PYENV=1
fi

if [[ $FOUND_PYENV -ne 1 ]]; then
  pyenvdirs=("$HOME/.pyenv" "/usr/local/pyenv" "/opt/pyenv" "/usr/local/opt/pyenv")
  for dir in $pyenvdirs; do
    if [[ -d "$dir/bin" ]]; then
      export PATH="$dir/bin:$PATH"
      FOUND_PYENV=1
    fi
  done
fi

if [[ $FOUND_PYENV -ne 1 ]]; then
  if (( $+commands[brew] )) && dir=$(brew --prefix pyenv 2>/dev/null); then
    if [[ -d "$dir/bin" ]]; then
      FOUND_PYENV=1
    fi
  fi
fi

if [[ $FOUND_PYENV -eq 1 ]]; then
  eval "$(pyenv init - --no-rehash zsh)"

  if [[ "$(pyenv commands)" =~ "virtualenv-init" && "$ZSH_PYENV_VIRTUALENV" != false ]]; then
    eval "$(pyenv virtualenv-init - zsh)"
  fi

  function pyenv_prompt_info() {
    local version="$(pyenv version-name)"
    echo "${version:gs/%/%%}"
  }
else
  # Fall back to system python
  function pyenv_prompt_info() {
    local version="$(python3 -V 2>&1 | cut -d' ' -f2)"
    echo "system: ${version:gs/%/%%}"
  }
fi

unset FOUND_PYENV pyenvdirs dir
