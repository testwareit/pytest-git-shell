#!/bin/bash

set -e

sh ./entry.sh
exec /usr/sbin/sshd -D