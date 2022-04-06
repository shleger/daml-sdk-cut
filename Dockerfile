## -*- dockerfile-image-name: "daml-sdk-cut" -*-
FROM azul/zulu-openjdk-alpine:17-jre
RUN addgroup -S cont && adduser -S cont -G cont


RUN apk add --no-cache curl tar bash procps 


USER cont:cont

RUN mkdir -p /home/cont/.daml/sdk/1.18.2 /tmp/daml-untar \
    && echo "Downloading daml" \
    && curl -fsSL -o /tmp/daml-sdk.tar.gz https://github.com/digital-asset/daml/releases/download/v1.18.2/daml-sdk-1.18.2-linux.tar.gz \
    && echo "Daml SDK downloaded" \
    && echo "Untarring daml-sdk" \
    && tar -xzf /tmp/daml-sdk.tar.gz -C /home/cont/.daml/sdk/1.18.2 --strip-components=1 
#    && echo "Copy to dest" \
#    && cp -R /tmp/daml-untar/daml /opt/daml \
#    && cp -R /tmp/daml-untar/daml-sdk /opt/daml/daml-sdk \
#    \
#     && echo "Cleaning and tmp files" \ 
#     && rm -f /tmp/daml-sdk.tar.gz \
#     && rm -rf /tmp/daml-untar
# 


#RUN chmod +x /opt/daml/daml
RUN ls -la /home/cont/.daml/sdk/1.18.2


EXPOSE 6865


# ARG JAR_FILE=target/*.jar
# COPY ${JAR_FILE} app.jar
ENTRYPOINT ["/home/cont/.daml/sdk/1.18.2/daml/daml"]
