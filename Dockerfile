FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /film-uploader-backend
COPY Gemfile /film-uploader-backend/Gemfile
COPY Gemfile.lock /film-uploader-backend/Gemfile.lock
RUN bundle install
COPY . /film-uploader-backend

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]