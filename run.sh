#!/bin/sh

if [ -z "${LFA_BUILDS_SSH_KEY}" ]
then
  echo "LFA_BUILDS_SSH_KEY not set"
  exit 1
fi

mkdir -p "${HOME}/.ssh" || exit 1
echo "${LFA_BUILDS_SSH_KEY}" | base64 -d > "${HOME}/.ssh/id_ed25519" || exit 1

chmod 700 "${HOME}/.ssh" || exit 1
chmod 600 "${HOME}/.ssh/id_ed25519" || exit 1

touch file.txt || exit 1

mkdir -p "${HOME}/.ssh" || exit 1
cat builds.lfa.one.pub >> "$HOME/.ssh/known_hosts" || exit 1

exec scp -v -v -P 1022 file.txt travis-ci@builds.lfa.one:~/
