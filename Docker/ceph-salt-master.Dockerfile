FROM opensuse/leap:latest
RUN zypper -n in \
    salt-master \
    salt-minion \
    python3-pip
RUN zypper -n in python3-curses

# For development/testing
RUN zypper -n in --recommends tmux vim vim-fzf man man-pages
RUN zypper -n in --force zypper

COPY . /ceph-salt
WORKDIR /ceph-salt
RUN pip3 install -r requirements.txt
