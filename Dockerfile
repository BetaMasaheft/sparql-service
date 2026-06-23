# syntax = docker/dockerfile:1.2
FROM ubuntu:latest AS builder

WORKDIR /home/ubuntu

RUN apt-get update && apt-get install -y curl unzip default-jre libsaxonb-java fd-find

# Download and unzip the archive for the expanded data
RUN --mount=type=secret,id=DEPLOY_PAT \
    curl -H "Authorization: token $(cat /run/secrets/DEPLOY_PAT)" -L https://github.com/BetaMasaheft/expanded/archive/refs/heads/main.zip -o main.zip &&\
    unzip -qj main.zip -d ./input/ &&\
    rm main.zip

COPY ./modules/ ./modules/

# Move the TEI files to one folder, in order to be faster processed by Saxon
RUN ./modules/move-tei-files/move-tei-files.sh

# Convert the expanded data from TEI to RDF/XML format
RUN ./modules/tei-to-rdf-xml/tei-to-rdf-xml.sh

#COPY ./sparql-service ./sparql-service

#RUN sparql-service

# file_name=$(basename "$file_path")
# file_base_name=`echo "$file_name" | cut -d'.' -f1`

# COPY --from=builder /home/x86_64-unknown-linux-musl/release/index-cards-to-indexes /home

# FROM adfreiburg/qlever:commit-b802870

# LABEL org.opencontainers.image.source=https://github.com/BetaMasaheft/collatex-service
# LABEL org.opencontainers.image.description="Docker container for using QLever as a web service"
# LABEL org.opencontainers.image.licenses=MIT
# LABEL org.opencontainers.image.authors="Claudius Teodorescu <claudius.teodorescu@gmail.com>"

# USER root

# RUN mkdir -p /data
# WORKDIR /data

# ARG DATA_DIR=data
# COPY output/* /data/ 

# ENV INPUT_FILES="/data/*.ttl"

# RUN qlever index \
#     --name "bm" \
#     --cat-input-files 'cat *.ttl' \
#     --input-files "*.ttl" \
#     --stxxl-memory "1GB" \
#     --parallel-parsing false \
#     --system "native"

# RUN find /data -name "*.ttl" -delete

# ENTRYPOINT ["qlever", "start", "--name", "bm", "--description", "bm", "--port", "7000", "--system", "native"]

# sudo docker build --progress=plain --secret id=DEPLOY_PAT,src=./DEPLOY_PAT -t sparql-service .
# sudo docker run -p 7000:7000 -p 8176:8176 sparql-service
# curl "http://localhost:7000/?query=select%20*%20where%20%7Bs%20?p%20?o%7D%20limit%207"
# curl "http://localhost:7000/?query=select%20*%20where%20%7B?s%20?p%20?o%7D%20limit%20777777"
