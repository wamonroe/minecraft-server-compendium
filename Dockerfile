# Make sure version matches the Ruby version in .tool-versions and Gemfile
FROM ruby:3.2.1-alpine

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV BUNDLE_PATH ".bundle"

# Install packages needed to build gems and node modules
RUN set -eux; \
    apk add --no-cache --virtual .build-deps \
        build-base \
        curl \
        git \
        postgresql14-dev \
        nodejs \
        yarn \
        vips \
    ; \
    apk add --no-cache --virtual .run-deps \
        postgresql14-client \
        gcompat \
        tzdata \
    ;

# Run as a non-root user
RUN set -eux; \
    adduser -D rails -s /bin/ash; \
    addgroup rails rails; \
    chown -R rails:rails /rails;
USER rails:rails

# Entrypoint prepares the database.
ENTRYPOINT ["/rails/bin/docker/entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
