FROM ruby:2.7.0

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
ENV RAILS_ENV=development
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]