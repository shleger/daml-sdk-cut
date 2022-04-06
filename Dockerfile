## -*- dockerfile-image-name: "daml-sdk-cut" -*-
FROM azul/zulu-openjdk-alpine:17-jre
RUN addgroup -S daml && adduser -S daml -G daml


RUN apk add --no-cache curl tar bash procps 


RUN mkdir -p /opt/daml /tmp/daml-untar \
    && echo "Downloading daml" \
    && curl -fsSL -o /tmp/daml-sdk.tar.gz https://github.com/digital-asset/daml/releases/download/v1.18.2/daml-sdk-1.18.2-linux.tar.gz \
    && echo "Daml SDK downloaded" \
    && echo "Untarring daml-sdk" \
    && tar -xzf /tmp/daml-sdk.tar.gz -C /tmp/daml-untar --strip-components=1 \
    && echo "Copy to dest" \
    && cp -R /tmp/daml-untar/daml /opt/daml \
    && cp -R /tmp/daml-untar/daml-sdk /opt/daml/daml-sdk \
    \
    && echo "Cleaning and tmp files" \ 
    && rm -f /tmp/daml-sdk.tar.gz \
    && rm -rf /tmp/daml-untar
#    && && ln -s /usr/share/daml/bin/mvn /usr/bin/mvn


#USER daml:daml

EXPOSE 6865

# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar
ENTRYPOINT ["/opt/daml/daml","sandbox"]
