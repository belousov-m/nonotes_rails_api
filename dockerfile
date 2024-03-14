FROM ruby:3.1.4-alpine
RUN apk add \
  build-base \
  postgresql-dev \
  tzdata
WORKDIR /app
COPY Gemfile* .
RUN bundle install
COPY . .
EXPOSE 3000
CMD [ "rails", "server","-p", "3000", "-b", "0.0.0.0" ]