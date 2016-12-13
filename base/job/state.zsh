__zplug::job::state::running()
{
    local job

    for job in "$argv[@]"
    do
        [[ $job == "" ]] && return 1
        if kill -0 "$job" &>/dev/null; then
            return 0
        fi
    done

    return 1
}

__zplug::job::state::get() {
    local repo="${1:?}" target="${2:?}"

    if [[ ! -f $_zplug_log[$target] ]]; then
        # TODO
        return 1
    fi

    cat "$_zplug_log[$target]" \
        | grep "^repo:$repo" \
        | awk '{print $2}' \
        | cut -d: -f2
    return $status
}

__zplug::job::state::kill() {
    local pid="${1:?}"

    if ! __zplug::job::state::running "$pid"; then
        # TODO
        return $status
    fi

    kill -9 $pid &>/dev/null
    return $status
}