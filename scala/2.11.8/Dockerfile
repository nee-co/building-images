FROM FIX_ME/buildpack-deps:curl
RUN apk add --no-cache --virtual .buildpack-deps tar && \
    apk add --no-cache openjdk8-jre && \
    set -e && for i in \
        "http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.tgz" \
        "https://dl.bintray.com/sbt/native-packages/sbt/0.13.12/sbt-0.13.12.tgz" \
      ; do curl --location $i | tar --gzip --extract --file - --directory /usr/local/ --strip-components 1 \
    ; done && \
    apk del .buildpack-deps
RUN sbt about
CMD ["scala"]