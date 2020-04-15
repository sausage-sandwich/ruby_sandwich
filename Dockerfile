FROM ruby:2.6.6

RUN apt-get update && apt-get install cron -y
RUN bundle config --global frozen 1

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN apt-get install -y locales
RUN dpkg-reconfigure locales && \
  locale-gen C.UTF-8 && \
  /usr/sbin/update-locale LANG=C.UTF-8

RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
  locale-gen
RUN gem install bundler
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
COPY .ruby-version /usr/src/app/
RUN bundle install

COPY . /usr/src/app

ENV LANG=en_US.UTF-8

EXPOSE 80
CMD ["./bin/start"]
