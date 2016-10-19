FROM fluent/fluentd:latest
MAINTAINER Eljas Alakulppi <eljas@callstats.io>
WORKDIR /home/fluent
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH

USER root
RUN apk --no-cache --update add sudo build-base ruby-dev && \
    sudo -u fluent gem install fluent-plugin-cloudwatch-logs && \
    sudo -u fluent gem install fluent-plugin-kubernetes_metadata_filter && \
    rm -rf /home/fluent/.gem/ruby/2.3.0/cache/*.gem && sudo -u fluent gem sources -c && \
    apk del sudo build-base ruby-dev && rm -rf /var/cache/apk/*

EXPOSE 24284

ADD fluent.conf /fluentd/etc/
CMD exec fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT
