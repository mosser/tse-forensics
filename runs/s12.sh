#!/bin/bash


## Loading DSL functions
source ./functions.sh

## describing what's expected this week
function handle_project_repository() # $1 = GRP, $2 = $PROJECT_NAME, $3 = URL
{
    # Short
    REMOTE=$3; D=$1-$2
    KEY=`echo $3 | cut -d ';' -f 3 | cut -d '/' -f 5 | tr '[A-Z]' '[a-z]'`

    # Check script
    clone_repository   $REMOTE $D
    checkout_git_tag   $D "week12"
    exists_file        $D .gitignore
    exists_pattern     $D '*.java'     "source files"
    not_exists_pattern $D '*.class'    "compiled classes"
    not_exists_pattern $D '*~'         "temporary files"
    not_exists_pattern $D '.classpath' "Eclipse classpath meta-data"
    not_exists_pattern $D '.project'   "Eclipse project meta-data"
    not_exists_pattern $D '.settings'  "Eclipse settings"
    exists_file        $D pom.xml 
    exists_directory   $D src/main/java/fr/unice/polytech/si3/tse/$KEY 
    xml_file_contains  $D pom.xml groupId fr\.unice\.polytech\.si3\.tse
    xml_file_contains  $D pom.xml artifactId $KEY
    run_maven          $D install
}

main



