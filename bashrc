source ~/.profile

if [ -f /etc/bashrc ]; then
    . /etc/bashrc
    . /etc/bash_completion

    # Remapping keys
    # tip: Ctrl+w delete a word backward and Esc+d delete a word forward
    bind '"\C-b"':'"\eb"'
    bind '"\C-f"':'"\ef"'

    PS1='<< \u AT \h :: \w$(__git_ps1 " [ %s ]") >> '
fi
