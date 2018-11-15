#!/usr/bin/env bash

set -eux

# Test pause module when no tty and non-interactive. This is to prevent playbooks
# from hanging in cron and Tower jobs.
/usr/bin/env bash << EOF
ansible-playbook test-pause-no-tty.yml -i ../../inventory 2>&1 | \
    grep '\[WARNING\]: Not waiting for response to prompt as stdin is not interactive' && {
        echo 'Successfully skipped pause in no TTY mode' >&2
        exit 0
    } || {
        echo 'Failed to skip pause module' >&2
        exit 1
    }
EOF

# Test redirecting stdout
# Issue #41717
ansible-playbook pause-3.yml -i ../../inventory > /dev/null \
    && echo "Successfully redirected stdout" \
    || echo "Failure when attempting to redirect stdout"

# Test pause with seconds and minutes specified
ansible-playbook test-pause.yml -i ../../inventory "$@"

# Interactively test pause
python test-pause.py -i ../../inventory "$@"
