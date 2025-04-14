ARG RUBY_VERSION=3.4.2
FROM ruby:$RUBY_VERSION-alpine AS base

## Base stage with all necessary libraries
## and dependencies to build the application and run it
## - build-base: To ensure certain gems can be compiled
## - git: Allow bundler to fetch and install ruby gems
## - nodejs: Required by Rails
## - sqlite-dev: For running tests in the container
## - tzdata: add time zone support
## - mariadb-dev: To allow use of MySQL2 gem
## - imagemagick: for image processing
## - gcompat: to avoid architecture-specific incompatibitilies
## https://docs.docker.com/build/cache/optimize/#use-cache-mounts
RUN --mount=type=cache,target=/var/cache/apk apk add --update --no-cache \
      bash build-base gcompat git imagemagick imagemagick-dev \
      mariadb-dev nodejs sqlite-dev tzdata libffi-dev yaml-dev


################################################################################
# bundler stage #
#################
FROM base AS prod_bundler
ARG BUNDLER_VERSION=2.3.7

ENV APP_PATH="/app/cul-it/bcl-up_server-webapp" \
      PATH="/app/cul-it/bcl-up_server-webapp:$PATH"

RUN gem install bundler:${BUNDLER_VERSION}

COPY Gemfile Gemfile.lock ./

RUN gem update --system && bundle install && \
      rm -rf ${BUNDLE_PATH}/cache/*.gem && \
      find ${BUNDLE_PATH}/ -name "*.c" -delete && \
      find ${BUNDLE_PATH}/ -name "*.o" -delete

WORKDIR /app/cul-it/bcl-up_server-webapp
COPY . .

#RUN bundle exec rake assets:precompile unless PRECOMPILE_ASSETS is set to false
ARG PRECOMPILE_ASSETS=true
RUN if [ "$PRECOMPILE_ASSETS" = "true" ]; then \
  bundle exec rake assets:precompile; \
  fi


################################################################################
# final stage #
###############
FROM base
ARG RAILS_ENV

ENV APP_GRP="bcl-up-g" APP_USER="bcl-up-u" \
      APP_PATH="/app/cul-it/bcl-up_server-webapp" \
      PATH=./bin:$PATH \
      RAILS_ENV=${RAILS_ENV}

RUN addgroup -S ${APP_GRP} && adduser -S ${APP_USER} -G ${APP_GRP}

COPY --from=prod_bundler --chown=${APP_USER}:${APP_GRP} /usr/local/bundle/ /usr/local/bundle/
COPY --from=prod_bundler --chown=${APP_USER}:${APP_GRP} ${APP_PATH} ${APP_PATH}

USER ${APP_USER}
WORKDIR ${APP_PATH}

EXPOSE 3000

## Script runs when container first starts
CMD ["/app/cul-it/bcl-up_server-webapp/bin/puma.sh"]
