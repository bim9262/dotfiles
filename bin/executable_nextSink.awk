#!/bin/awk -f

BEGIN {
    cmd = "pactl get-default-sink"
    cmd | getline current_sink
    close(cmd)
    cmd = "pactl list short sinks";
    name_col = 2
    status_col = 7
    next_sink = ""
    i = 0
    previous_was_running = 0
    while(cmd | getline line) {
        split(line, line_split)
        sink = line_split[name_col]
        status = line_split[status_col]
        if (i++ == 0 || previous_was_running) {
            next_sink = sink
            if (previous_was_running) {
                break
            }
        }
        previous_was_running = sink == current_sink
    }
    close(cmd)
    print current_sink, next_sink
    exit system("pactl set-default-sink " next_sink)
}
