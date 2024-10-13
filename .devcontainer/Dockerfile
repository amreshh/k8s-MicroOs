FROM registry.opensuse.org/opensuse/leap:15.6

ENV OPENTOFU_VERSION="1.8.3"
ENV TALOS_VERSION="v1.8.1"

ADD ./opentofu.repo /etc/zypp/repos.d/opentofu.repo

RUN zypper --gpg-auto-import-keys refresh opentofu
RUN zypper --gpg-auto-import-keys refresh opentofu-source
RUN zypper install -y tar \
    gzip \
    git \
    kubernetes-client \
    tofu-${OPENTOFU_VERSION}
RUN curl -L https://github.com/siderolabs/talos/releases/download/${TALOS_VERSION}/talosctl-linux-amd64 -o /usr/local/bin/talosctl && chmod +x /usr/local/bin/talosctl


RUN echo 'alias ls="ls --color"' >>~/.bashrc
RUN echo 'talosctl completion bash' >>~/.bashrc
RUN echo 'kubectl completion bash' >>~/.bashrc
