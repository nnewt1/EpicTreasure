############################################################
# Dockerfile to build Epictreasure container
# Based on Ubuntu
############################################################

FROM ubuntu:24.04
ENV test false
LABEL maintainer="Robert Walls <rjwalls@wpi.edu>" 

RUN apt-get update && \
    apt-get -y install locales

RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8     

RUN mkdir -p /root/tools

RUN apt-get update && \
    apt-get -y install python3 python3-dev python3-pip && \
    apt-get clean

# Install basic utils
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    man build-essential curl gdb gdbserver wget vim unzip git \
    strace ltrace binutils file less netcat-openbsd \
    ripgrep

# Install pwntools and pwndbg
# RJW: We have to use the --break-system-package flag or the install will error out.
# A possible alternative is to use virtual environments. 
RUN apt-get update && \
    apt-get -y install python3 python3-pip python3-dev git libssl-dev libffi-dev build-essential && \
    python3 -m pip install --upgrade --break-system-packages pwntools

# Install Gef
RUN bash -c "$(wget https://gef.blah.cat/sh -O -)"

# Install seccomp-tools
RUN apt-get update && \
    apt-get -y install gcc ruby-dev && \
    gem install seccomp-tools && \
    apt-get clean

# Install ROPgadget
RUN python3 -m pip install --upgrade --break-system-packages ROPgadget

# Install one_gadget
RUN gem install one_gadget

# Install Valgrind
Run apt-get update && \
    apt-get -y install valgrind && \
    apt-get clean

# Install tmux
RUN apt-get update && \
    apt-get -y install tmux && \
    apt-get clean

WORKDIR /root/tools
# Install patchelf 
RUN apt-get update && \
  apt-get -y install autoconf && \
  git clone --depth 1 https://github.com/NixOS/patchelf.git && \
  cd patchelf && \
  ./bootstrap.sh && \
  ./configure && \
  make && \
  make install

# Install tqdm (python progress bar)
RUN python3 -m pip install --upgrade --break-system-packages tqdm

# Install openvpn 
RUN apt-get update && \
    apt-get -y install openvpn && \
    apt-get clean

# Setup VIM
#  - Install Pathogen 
RUN mkdir -p /root/.vim/autoload /root/.vim/bundle && \
    curl -LSso /root/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# - Install Harlequin colorscheme
WORKDIR /root/.vim/bundle
RUN git clone https://github.com/nielsmadan/harlequin.git 


COPY tmux.conf /root/.tmux.conf
COPY bash_aliases /root/.bash_aliases
COPY vimrc /root/.vimrc

COPY test.sh /root/test.sh
RUN chmod u+x /root/test.sh 

CMD sh -c 'if [ "$test" = true ]; then echo "Running tests"; chmod +x /root/test.sh; /root/test.sh; else /bin/bash; fi'
