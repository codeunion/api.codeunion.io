FROM zspencer/centos-ruby:1.9.3-p551

RUN yum -y install ruby postgresql-devel
RUN gem install json_pure
RUN gem update --system
RUN gem install bundler

EXPOSE 3000
WORKDIR /src
CMD make build
