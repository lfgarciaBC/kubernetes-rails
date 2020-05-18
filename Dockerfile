FROM ruby:2.7.0

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

RUN rm bin/*
RUN rake app:update:bin
# RUN rake assets:precompile

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

ENV RAILS_ENV=development
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]