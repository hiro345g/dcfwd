if [ ! -e ${HOME}/.local/bin/fossil ]; then
    if [ "x${USER}" = "x" ]; then
        apt-get update && apt-get -y upgrade
        apt-get -y install curl sqlite3
    fi
    curl -sLJO https://www.fossil-scm.org/home/uv/fossil-linux-x64-2.23.tar.gz
    if [ ! -e ${HOME}/.local/bin ]; then
        mkdir -p ${HOME}/.local/bin
    fi
    tar xf fossil-linux-x64-2.23.tar.gz -C ${HOME}/.local/bin/
fi

PATH=${HOME}/.local/bin:${PATH}
