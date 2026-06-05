LABEL org.opencontainers.image.source=https://github.com/BetaMasaheft/collatex-service
LABEL org.opencontainers.image.description="Docker container for using QLever as a web service"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.authors="Claudius Teodorescu <claudius.teodorescu@gmail.com>"

FROM adfreiburg/qlever:commit-b802870

USER root

RUN mkdir -p /data
WORKDIR /data

ARG DATA_DIR=data
COPY output/* /data/ 

ENV INPUT_FILES="/data/*.ttl"

RUN qlever index \
    --name "bm" \
    --cat-input-files 'cat *.ttl' \
    --input-files "*.ttl" \
    --stxxl-memory "12GB" \
    --parallel-parsing false \
    --system "native"

RUN find /data -name "*.ttl" -delete

ENTRYPOINT ["qlever", "start", "--name", "bm", "--description", "bm", "--port", "7000", "--system", "native"]

# sudo docker build -t sparql-service .
# sudo docker run -p 7000:7000 -p 8176:8176 sparql-service
# curl "http://localhost:7000/?query=select%20*%20where%20%7Bs%20?p%20?o%7D%20limit%207"
