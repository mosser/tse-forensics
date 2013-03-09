#!/bin/bash

## Clone a remote Git repository
function clone_repository() # $1 = URL / $2 = DIRECTORY
{
    echo -ne "Cloning project from remote repository: "
    git clone $1 $2 > /dev/null 2> /dev/null
    if [ "$?" = "0" ]; then echo "OK"; else echo "FAILURE"; fi
}


## Checkout a given tag in a local Git repository
function checkout_git_tag() # $1 = Directory, $2 = tag
{
    cd $1
    echo -ne "Checking out tag [$2]: "
    git checkout $2  > /dev/null 2> /dev/null
    if [ "$?" = "0" ]; then echo "OK"; else echo "FAILURE"; fi
    cd ..
}

## Test if a given file exists and is non empty
function exists_file() # $1 = Directory, $2 = file_name
{
    cd $1
    echo -ne "Checking existence of [$2]: "
    if [ -s $2 ]; then echo "OK"; else echo "FAILURE"; fi
    cd ..
}


## Test if a given pattern match files 
function exists_pattern() # $1 = Directory, $2 = pattern, $3 = nickname
{
    cd $1
    echo -ne "Checking existence of $3 [$2]: "
    find . -name "$2" | egrep '.*'  > /dev/null 2> /dev/null
    if [ "$?" = "0" ]; then echo "OK"; else echo "FAILURE"; fi
    cd ..
}

## Test if a given pattern does not match files 
function not_exists_pattern() # $1 = Directory, $2 = pattern, $3 = nickname
{
    cd $1
    echo -ne "Checking non-existence of $3 [$2]: "
    find . -name "$2" | egrep '.*'  > /dev/null 2> /dev/null
    if [ "$?" = "0" ]; then echo "FAILURE"; else echo "OK"; fi
    cd ..
}

## run the ant command 
function run_ant() # $1 = Directory, $2 = Target
{
    cd $1
    echo -ne "Compiling using ant: "
    ant $2 > /dev/null 2> /dev/null
    if [ "$?" = "0" ]; then echo "OK"; else echo "FAILURE"; fi
    cd ..
}


## Call the "handle_project_repository" function (to be defined) for each
## known project (in repositories.data.txt)
function main() 
{
    echo -ne "# Start time:"
    date "+%Y-%m-%d %H:%M:%S"
    for l in `cat repositories.data.txt`
    do
	GRP=`echo $l | cut -f 1 -d';'`
	DIR=`echo $l | cut -f 2 -d';'`
	URL=`echo $l | cut -f 3 -d';'`
	echo "   ## Project-Team [$DIR] ##"
	handle_project_repository $GRP $DIR $URL
	echo 
    done
    echo -ne "# End time:"
    date "+%Y-%m-%d %H:%M:%S"
}

