FROM fluent/fluentd:v0.14-onbuild
MAINTAINER Eljas Alakulppi <eljas@callstats.io>

RUN apk add --update --virtual .build-deps \
        sudo build-base ruby-dev \
        && sudo gem install fluent-plugin-cloudwatch-logs \
        && sudo gem install fluent-plugin-kubernetes_metadata_filter \
        && sudo gem sources --clear-all \
        && apk del .build-deps \
        && rm -rf /var/cache/apk/* \
                  /home/fluent/.gem/ruby/2.3.0/cache/*.gem

EXPOSE 24284
