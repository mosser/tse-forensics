#!/bin/bash


## Loading DSL functions
source ./functions.sh

## describing what's expected this week
function handle_project_repository() # $1 = GRP, $2 = $PROJECT_NAME, $3 = URL
{
    REMOTE=$3; D=$1-$2
    clone_repository   $REMOTE $D
    checkout_git_tag   $D "v0.1"
    exists_file        $D .gitignore
    exists_pattern     $D '*.java' "source files"
    not_exists_pattern $D '*.class' "compiled classes"
    not_exists_pattern $D '*~'   "temporary files"
    exists_file        $D build.xml
    run_ant            $D compile
}

main



