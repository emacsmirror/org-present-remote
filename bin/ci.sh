#!/usr/bin/env sh

set -e

apt update -qq
apt install -y emacs-nox

emacs \
    -batch \
    -l tests/test-setup.el \
    -l ert \
    -l org-present-remote.el \
    -l tests/unit-tests.el \
    -l tests/integration-tests.el \
    -f ert-run-tests-batch-and-exit
