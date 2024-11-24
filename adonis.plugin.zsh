function is_adonis_project() {
    [ -f ace ] || [ -f "node_modules/.bin/ace" ]
}

function ace() {
    local ace_path=$(_ace_find)

    if [ "$ace_path" = "" ]; then
        echo >&2 "zsh-ace: ace not found. Are you in an AdonisJS directory?"
        return 1
    fi

    local ace_cmd="node $ace_path"
    local ace_start_time=$(date +%s)

    eval $ace_cmd $*

    local ace_exit_status=$? # Store the exit status so we can return it later

    if [[ $1 = "make:"* && $ACE_OPEN_ON_MAKE_EDITOR != "" ]]; then
        # Find and open files created by ace
        find \
            "$adonis_path/app" \
            "$adonis_path/tests" \
            "$adonis_path/database" \
            -type f \
            -newermt "-$(($(date +%s) - $ace_start_time + 1)) seconds" \
            -exec $ACE_OPEN_ON_MAKE_EDITOR {} \; 2>/dev/null
    fi

    return $ace_exit_status
}

compdef _ace_add_completion ace

function _ace_find() {
    # Look for ace, ace.js, or ace.ts up the file tree until the root directory
    local dir=.
    until [ $dir -ef / ]; do
        if [ -f "$dir/ace" ] || [ -f "$dir/ace.js" ] || [ -f "$dir/ace.ts" ]; then
            echo "$dir/ace"
            return 0
        fi

        dir+=/..
    done

    return 1
}

function _ace_add_completion() {
    if [ "$(_ace_find)" != "" ]; then
        compadd $(_ace_get_command_list)
    fi
}

function _ace_get_command_list() {
    node ace list --no-ansi | awk '/^\s+[a-zA-Z0-9:]+\s+/{print $1}'
}
