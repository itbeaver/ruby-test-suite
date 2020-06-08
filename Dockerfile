FROM ubuntu:18.04
MAINTAINER Alexander Bobrov, ITBeaver <al.bobrov@itbeaver.co>

RUN apt-get update \
  &&  apt-get upgrade -y \
  &&  apt-get install -y \
      libssl-dev \
      libreadline-dev \
      wget \
      curl \
      git \
      build-essential \
      imagemagick \
      libmagick++-dev \
      libffi-dev \
      mysql-client \
      libmysqlclient-dev \
      xvfb \
      phantomjs \
      wkhtmltopdf \
  &&  apt-get clean \
  &&  rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*

RUN git clone git://github.com/rbenv/rbenv.git /usr/local/rbenv \
  &&  git clone git://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build \
  &&  git clone git://github.com/jf/rbenv-gemset.git /usr/local/rbenv/plugins/rbenv-gemset \
  &&  /usr/local/rbenv/plugins/ruby-build/install.sh

ENV PATH /usr/local/rbenv/bin:$PATH
ENV RBENV_ROOT /usr/local/rbenv

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /etc/profile.d/rbenv.sh \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /etc/profile.d/rbenv.sh \
&&  echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh

RUN echo 'export RBENV_ROOT=/usr/local/rbenv' >> /root/.bashrc \
&&  echo 'export PATH=/usr/local/rbenv/bin:$PATH' >> /root/.bashrc \
&&  echo 'eval "$(rbenv init -)"' >> /root/.bashrc

ENV CONFIGURE_OPTS --disable-install-doc
ENV PATH /usr/local/rbenv/bin:/usr/local/rbenv/shims:$PATH

ENV RBENV_VERSION 2.4.2

RUN eval "$(rbenv init -)"; rbenv install $RBENV_VERSION \
&&  eval "$(rbenv init -)"; rbenv global $RBENV_VERSION \
&&  eval "$(rbenv init -)"; gem update --system \
&&  eval "$(rbenv init -)"; gem install bundler -v "1.17.3" -f \
&&  rm -rf /tmp/* \

# node.js LTS install
RUN curl --silent --location https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs \
  && npm -g up

# yarn install
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN localedef ru_RU.UTF-8 -i ru_RU -fUTF-8 &&\
    locale-gen ru_RU.UTF-8 &&\

    # Setup node packages
    npm install -g jshint
