# Same environment as the builder stage of the main Dockerfile: the
# TEI->RDF/XML golden outputs depend on the exact Saxon version, so the
# tests must run the pipeline with bullseye's libsaxonb-java, not with
# whatever the host or CI runner provides.
FROM rust:bullseye

RUN apt-get update && apt-get install -y default-jre libsaxonb-java && rm -rf /var/lib/apt/lists/*

WORKDIR /work
