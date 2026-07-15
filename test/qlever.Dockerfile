# QLever serving an index built from the frozen test fixtures only —
# same base image and flags as the main Dockerfile, without the full
# dataset (no DEPLOY_PAT needed). Build from the repository root:
#   docker build -t sparql-service-test -f test/qlever.Dockerfile .
FROM adfreiburg/qlever:commit-b802870

USER root

WORKDIR /data

COPY test/fixtures/ttl/*.ttl .

RUN qlever index \
    --name "bm" \
    --cat-input-files 'cat *.ttl' \
    --input-files "*.ttl" \
    --stxxl-memory "1GB" \
    --parallel-parsing false \
    --system "native"

RUN find /data -name "*.ttl" -delete

ENTRYPOINT ["qlever", "start", "--name", "bm", "--description", "bm", "--port", "7000", "--system", "native"]
