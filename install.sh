#!/bin/bash
# Yanan Zhao, 2016

UPDATE_PLUGINS=0

print_help() {
    echo "Usage: $0 [Options]"
    echo "Options:"
    echo "  -h/--help           print this help message and exit"
    echo "  -u/--update-plugins use lasted plugins on install. Default false."
    echo "                      NOTE this may be time-consuming as it will"
    echo "                      pull the plugins from github"
}

if [ $# -eq 1 ]; then
    if [[ $1 = "-h" || $1 = "--help" ]]; then
        print_help
        exit 1
    elif [[ $1 = "-u" || $1 = "--update-plugins" ]]; then
        echo "update plugins: true"
        UPDATE_PLUGINS=1
    else
        echo "unkown options: $@"
    fi
fi

vim_runtime_dir=$HOME/.vim_runtime
cur_vim_runtime_dir=$PWD/.vim_runtime

# step.1. backup your old configurations
echo -e "\033[36m[1] backing up current configurations ...\033[0m"
# if [ -d $vim_runtime_dir ]; then
#     echo -e "old $vim_runtime_dir exists, skiping backing up"
# else
# backup directory
# with two leading dots to distinguish it from vim configuration files
backup_dir=$HOME/..vimback # with two leading dots to distinguish it from vim

if [ -d $backup_dir ]; then
    echo -e "$backup_dir already exists, refresh it"
    rm -rf $backup_dir
fi

mkdir $backup_dir
mv $HOME/.vim* $backup_dir

echo -e "\033[34mbackup successful\033[0m"
echo -e ""

# step.2. update plugins
echo -e "\033[36m[2] updating plugins ...\033[0m"
if [ $UPDATE_PLUGINS -eq 1 ]; then
    $cur_vim_runtime_dir/update_plugins.py
    if [ $? -gt 0 ]; then
        echo -e "\033[31minstall abort\033[0m"
        exit 1
    fi
    echo -e "\033[34mupdate successful\033[0m"
else
    echo -e "\033[34mskip updating plugins as -u/--update-plugins not specified\033[0m"
fi
echo -e ""

# step.3. install
echo -e "\033[36m[3] install new configurations ...\033[0m"
find . -name ".ropeproject" -exec rm -rf {} +
ln -sf $cur_vim_runtime_dir $vim_runtime_dir && sh $vim_runtime_dir/install_awesome_vimrc.sh
echo -e "\033[34minstall finish\033[0m"
