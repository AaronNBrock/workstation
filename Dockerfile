FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    git \
    git \
    zsh \
    tmux \
    curl \
    vim


# Create User
RUN useradd -ms /bin/bash me
RUN usermod -aG sudo me
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers


USER me
WORKDIR /home/me
ENV HOME /home/me

# Oh my zsh
ENV ZSH_CUSTOM $HOME/.oh-my-zsh/custom

# RUN mkdir -p $ZSH_CUSTOM/plugins

RUN git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git $HOME/.oh-my-zsh

# Themes
RUN git clone --depth 1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# Plugins
RUN git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
RUN git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
RUN git clone --depth 1 https://github.com/zsh-users/zsh-completions.git $ZSH_CUSTOM/plugins/zsh-completions
RUN git clone --depth 1 https://github.com/esc/conda-zsh-completion.git $ZSH_CUSTOM/plugins/conda-zsh-completion

COPY ./dotfiles .

ENTRYPOINT [ "/bin/zsh" ]