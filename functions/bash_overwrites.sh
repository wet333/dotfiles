my_cd() {
    builtin cd "$@"

    # Add extra commands here ...
    set_prompt # dinamically sets the command prompt after cd
}