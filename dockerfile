FROM ruby:3.1.4-alpine
RUN apk add \
  build-base \
  postgresql-dev \
  tzdata
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .
EXPOSE 3000
CMD ["/bin/sh", "-c", "bundle exec docker/start.sh"]