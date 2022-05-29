FROM ruby:3.2.0-preview1

RUN mkdir -p /var/app
COPY . /var/app
WORKDIR /var/app

RUN apt-get update && apt-get install -y npm && npm install yarn && apt-get install -y cron

RUN bundle install

CMD whenever --update-crontab
CMD rails s -b 0.0.0.0