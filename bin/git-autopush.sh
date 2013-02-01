#!/bin/sh

usage()
{
cat << EOF
usage $0 [<options>] [-r <remoterepo>]

Will add a post-commit function in the git repo which will automatically push
to the default or remote repo.

OPTIONS:
 -o Overwrite any existing post-commit hook
 -r Remote repo
 -s install serverside hook to autocheckout
EOF
}
params="$@"

OVERWRITE=0

HOOKS_FOLDER=.git/hooks
POST_COMMIT=$HOOKS_FOLDER/post-commit
POST_UPDATE=$HOOKS_FOLDER/post-update
HOOK=$POST_COMMIT
SERVERHOOK=0

while getopts  "hors:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
    ;;
    o)
      OVERWRITE=1
    ;;
    r)
      REMOTEREPO="$OPTARG"
    ;;
    s)
      SERVERHOOK=1
      HOOK=$POST_UPDATE
    ;;
  esac
done
shift $(( $OPTIND - 1 ))

if [ -d $HOOKS_FOLDER ]; then
  if [ -f $HOOK ] && [ $OVERWRITE -eq 0 ]; then
    echo "hook already exits, please add it manually in $HOOK"
    exit 1
  fi
  if [ $OVERWRITE -eq 1 ]; then
    mv $HOOK "$HOOK.bak"
    echo "moved old hook to $HOOK.bak"
  fi
  if [ $SERVERHOOK -eq 0 ]; then
    echo "git push $REMOTEREPO" > $HOOK
  else
    echo "git checkout -f master" > $HOOK
  fi
  chmod 755 $HOOK
  REPOSITORY_BASENAME=$(basename "$PWD")
  echo "added hook to $REPOSITORY_BASENAME"
  exit 0
else
  echo "This command must be run in the root of a Git repository."
  exit 1
fi
