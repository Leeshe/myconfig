#!/bin/bash

source ../install.sh

echo -e "${BACKGROUND_GREEN}Executing install script in '${PWD##*/}'${NC}"

#------------------------------------------------------------------
# @description      Directories for configuration
#-----------------------------------------------------------------
readonly LOCAL_BIN="/usr/local/bin"

#------------------------------------------------------------------
# @description      Create symlinks for bash scripts
#------------------------------------------------------------------
createSymLinks() {
    readonly BASH_SCRIPTS=(
        update
        upgrade
        ccl
    )

    for symlink in "${BASH_SCRIPTS[@]}"; do
        messageCreateSymlink="Creating symlink '$symlink'"
        commandCreateSymlink="ln -s $CURRENT_DIR/$symlink.sh $LOCAL_BIN/$symlink"

        evaluateCreateSymlink "$messageCreateSymlink" "$commandCreateSymlink"
    done
}

if [ "${PWD##*/}" == "bash_script" ]
then
    createSymLinks
    printf "${BACKGROUND_GREEN}END OF 'bash_script'${NC}"
fi

exit 0
