FROM ruby:2.6

WORKDIR /app

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . ./

ENTRYPOINT ["ruby", "app.rb", "-o", "0.0.0.0"]

EXPOSE 4567 






































