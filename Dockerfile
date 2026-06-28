# syntax = docker/dockerfile:1.2
FROM rust:bullseye AS ubuntu-builder

WORKDIR /home/ubuntu

RUN apt-get update && apt-get install -y curl unzip default-jre libsaxonb-java fd-find

# Download and unzip the archive for the expanded data
RUN --mount=type=secret,id=DEPLOY_PAT \
    curl -H "Authorization: token $(cat /run/secrets/DEPLOY_PAT)" -L https://github.com/BetaMasaheft/expanded/archive/refs/heads/main.zip -o main.zip &&\
    mkdir -p ./data/01-unzip-tei-files/ &&\
    unzip -qj main.zip -d ./data/01-unzip-tei-files/ &&\
    rm main.zip

COPY ./modules/ ./modules/

# Convert the expanded data from TEI to RDF/XML format
RUN ./modules/tei-to-rdf-xml/tei-to-rdf-xml.sh

# Compile the executable for conversion form RDF/XML to RDF/Turtle
WORKDIR /home/ubuntu/sparql-service-dir

COPY ./src/ ./src/
COPY ./Cargo.toml .

RUN cargo build --bin sparql-service --target-dir ./target --release --target x86_64-unknown-linux-gnu &&\
    cp ./target/x86_64-unknown-linux-gnu/release/sparql-service /home/ubuntu

WORKDIR /home/ubuntu

# Convert the expanded data from RDF/XML to RDF/Turtle format

RUN ./sparql-service /home/ubuntu/data/02-tei-to-rdf-xml /home/ubuntu/data/03-rdf-xml-to-rdf-turtle
RUN ls -l /home/ubuntu/data/03-rdf-xml-to-rdf-turtle

FROM adfreiburg/qlever:commit-b802870

LABEL org.opencontainers.image.source=https://github.com/BetaMasaheft/sparql-service
LABEL org.opencontainers.image.description="Docker container for using QLever as a web service"
LABEL org.opencontainers.image.licenses=MIT
LABEL org.opencontainers.image.authors="Claudius Teodorescu <claudius.teodorescu@gmail.com>"

USER root

WORKDIR /data

COPY --from=ubuntu-builder /home/ubuntu/data/03-rdf-xml-to-rdf-turtle .

ARG DATA_DIR=data

ENV INPUT_FILES="/data/*.ttl"

RUN qlever index \
    --name "bm" \
    --cat-input-files 'cat *.ttl' \
    --input-files "*.ttl" \
    --stxxl-memory "1GB" \
    --parallel-parsing false \
    --system "native"

RUN find /data -name "*.ttl" -delete

ENTRYPOINT ["qlever", "start", "--name", "bm", "--description", "bm", "--port", "7000", "--system", "native"]

# sudo docker build --progress=plain --secret id=DEPLOY_PAT,src=./DEPLOY_PAT -t sparql-service .
# sudo docker run -p 7000:7000 -p 8176:8176 sparql-service
# curl "http://localhost:7000/?query=select%20*%20where%20%7Bs%20?p%20?o%7D%20limit%207"
# curl "http://localhost:7000/?query=select%20*%20where%20%7B?s%20?p%20?o%7D%20limit%20777777"
