FROM ruby:2.4.1

# add node 7.9.0, yarn repogitory and reflesh cache
# https://nodejs.org/en/download/package-manager/
# https://yarnpkg.com/lang/en/docs/install/#linux-tab
RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq

# install nodejs and yarn
RUN apt-get install -y build-essential nodejs yarn

# for rails using db
RUN apt-get install -y mariadb-client

# move /app
ENV APP_HOME /app
WORKDIR ${APP_HOME}

# for change bundle install directory
ENV BUNDLE_HOME /vendor/bundle
ENV BUNDLE_PATH $BUNDLE_HOME
ENV BUNDLE_BIN $BUNDLE_HOME/bin
ENV BUNDLE_APP_CONFIG $BUNDLE_HOME

# install bundler on client
RUN gem install bundler -v '~> 1.14'
