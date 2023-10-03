# Asreix - if you branch have a not indexing changes
function gbranch() {
    if [ -d ".git" ]; then
        if output="$(git status --porcelain)" && [ -z "$output" ]; then
            echo -e "\e[33m[$(git describe --all --exact-match | sed 's/heads\///')]"
        else
            echo -e "\e[33m[$(git describe --all --exact-match | sed 's/heads\///')*]"
        fi
    fi
}

function kctx() {
    echo -e "\e[36m($(kubectl config current-context):$(kubectl config view --minify -o jsonpath='{..namespace}'))"
}

function err_occured() {
    if [[ $? -eq 0 ]]; then
        echo -e "\e[32m⊚ "
    else
        echo -e "\e[31m⊚ "
    fi
}

# Find this block in your ~/.bashrc file
if [ "$color_prompt" = yes ]; then
    PS1='$(err_occured)$(gbranch)$(kctx)' #Add this line
    PS1+='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[00m\]:\[\e[01;34m\]\w\[\e[00m\]\$ ' # Change this line (= -> +=)
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
