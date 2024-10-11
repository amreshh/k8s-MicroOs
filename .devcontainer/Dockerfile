FROM registry.opensuse.org/opensuse/leap:15.6

ENV OPENTOFU_VERSION="1.8.2-1"

ADD ./opentofu.repo /etc/zypp/repos.d/opentofu.repo

RUN zypper --gpg-auto-import-keys refresh opentofu
RUN zypper --gpg-auto-import-keys refresh opentofu-source
RUN zypper install -y tar \
    gzip \
    git \
    # butane \
    # kubernetes-client \
    # talosctl \
    # talosctl-bash-completion \
    tofu-${OPENTOFU_VERSION}

RUN echo 'alias ls="ls --color"' >>~/.bashrc
# RUN echo 'talosctl completion bash' >>~/.bashrc
# RUN echo 'kubectl completion bash' >>~/.bashrc
