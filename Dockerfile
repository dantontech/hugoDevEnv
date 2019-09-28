FROM ubuntu:bionic as baseos
MAINTAINER dantontech <danton@danton.tech>
#
ENV  HUGO_VERSION=0.58.3 
#
WORKDIR /tmp
#
RUN  sed -i -e 's/^deb-src/#deb-src/' /etc/apt/sources.list \
     && export DEBIAN_FRONTEND=noninteractive \
     && apt-get update \
     && apt-get upgrade -y --no-install-recommends \
     && apt-get install -y --no-install-recommends \
     apt-transport-https \
     bash \
     bash-completion \
     build-essential \
     ca-certificates \
     ctags \
     curl \
     dnsutils \
     git-core \
     git \
     gnupg2 \
     htop \
     iproute2 \
     iputils-ping \
     less \
     locales \
     lynx \
     mtr \
     netcat \
     net-tools \
     nmap \
     openssh-client \
     p7zip-full \
     software-properties-common \
     tmux \
     && locale-gen en_US.UTF-8 
#
RUN add-apt-repository ppa:neovim-ppa/unstable \
     && apt-get update && apt-get install -y \
     neovim
#
RUN curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -C /usr/local/bin -xz 
#
RUN apt-get autoremove -y \
     && apt-get clean -y \
     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/man /usr/share/doc   
#
RUN useradd -ms /bin/bash -u 1001 danton
#
USER danton
#
WORKDIR /home/danton
#
RUN git clone https://github.com/dantontech/dotfiles.git
#
RUN /home/danton/dotfiles/install.sh
#
CMD ["bash"]
