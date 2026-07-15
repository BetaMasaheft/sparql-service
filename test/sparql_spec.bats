#!/usr/bin/env bats

# Golden-output tests for the two pipeline stages and the QLever service.
#
# Prerequisites (see README "Tests"):
#   docker build -t sparql-pipeline-test -f test/pipeline.Dockerfile test/
#   docker build -t sparql-service-test -f test/qlever.Dockerfile .
#   docker run -d --rm --name qlever -p 7071:7000 sparql-service-test
#   bats --tap test/sparql_spec.bats
#
# The pipeline stages run inside the pipeline image because the
# TEI->RDF/XML output depends on the exact Saxon version (bullseye's
# libsaxonb-java, same as the main Dockerfile's builder stage).
# Turtle outputs are compared after canonicalize-bnodes.awk: the
# RDF/XML parser assigns random blank-node labels on every run.
# Query results are compared after `jq -S 'del(.meta)'`: the meta
# object carries per-run query timings.

PIPELINE_IMAGE="${PIPELINE_IMAGE:-sparql-pipeline-test}"
QLEVER_URL="${QLEVER_URL:-http://localhost:7071}"
FIXTURES="test/fixtures"
OUT_DIR="test/.out"

setup_file() {
  rm -rf "$OUT_DIR"
  mkdir -p "$OUT_DIR/rdf-xml" "$OUT_DIR/ttl"
  docker run --rm --platform linux/amd64 -v "$PWD":/work "$PIPELINE_IMAGE" bash -c "
    set -e
    saxonb-xslt -s:$FIXTURES/tei -o:$OUT_DIR/rdf-xml -xsl:modules/tei-to-rdf-xml/data2rdf.xsl
    cargo run --quiet --bin sparql-service $OUT_DIR/rdf-xml $OUT_DIR/ttl 2>/dev/null
  "
}

@test "TEI to RDF/XML matches the golden outputs" {
  diff -r "$OUT_DIR/rdf-xml" "$FIXTURES/rdf-xml"
}

@test "RDF/XML to Turtle matches the golden outputs (canonical blank nodes)" {
  for f in "$OUT_DIR"/ttl/*.ttl; do
    awk -f test/canonicalize-bnodes.awk "$f" | diff - "$FIXTURES/ttl/$(basename "$f")"
  done
}

run_query() {
  curl -sf -H 'Accept: application/sparql-results+json' \
    --data-urlencode "query=$(cat "$FIXTURES/queries/$1.rq")" \
    -G "$QLEVER_URL/" | jq -S 'del(.meta)'
}

@test "SPARQL: triple count over the fixture index" {
  run_query count-triples | diff - "$FIXTURES/queries/count-triples.expected.json"
}

@test "SPARQL: person properties (IRIs and literals, ordered)" {
  run_query person-properties | diff - "$FIXTURES/queries/person-properties.expected.json"
}

@test "SPARQL: subjects linked to the project (ordered)" {
  run_query subjects-in-betamasaheft | diff - "$FIXTURES/queries/subjects-in-betamasaheft.expected.json"
}
