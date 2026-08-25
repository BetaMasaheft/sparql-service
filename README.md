# sparql-service


## Resources

* [Linked Open Data Based on La Syntaxe du Codex for Manuscripts in Beta maṣāḥǝft](https://dlib.nyu.edu/awdl/isaw/isaw-papers/20-7/)

## Tests

Golden-output tests live in `test/sparql_spec.bats` and cover the two pipeline stages (TEI→RDF/XML via Saxon, RDF/XML→Turtle via the Rust converter) plus SPARQL queries against a QLever index built from the frozen fixtures in `test/fixtures/` — no `DEPLOY_PAT` or dataset download needed. Requires `bats`, `curl`, `jq`, and Docker:

```sh
docker build -t sparql-pipeline-test -f test/pipeline.Dockerfile test/
docker build -t sparql-service-test -f test/qlever.Dockerfile .
docker run -d --rm --name qlever -p 7071:7000 sparql-service-test
bats --tap test/sparql_spec.bats
```

CI runs them on every push before the image is built and pushed to ghcr. Notes on determinism, baked into the harness:

* the pipeline stages run inside `test/pipeline.Dockerfile` because the TEI→RDF/XML output depends on the exact Saxon version (bullseye's `libsaxonb-java`, as in the main Dockerfile);
* Turtle is compared after `test/canonicalize-bnodes.awk` — the RDF/XML parser assigns random blank-node labels on every run;
* query results are compared after `jq -S 'del(.meta)'` (per-run timings) and every multi-row query uses `ORDER BY`.

The fixtures are deliberately **frozen**: unlike `data/`, they must not be regenerated when the upstream dataset changes — only when a deliberate pipeline change alters the expected output (regenerate by running the commands above and copying `test/.out/` over the fixtures, re-canonicalising the Turtle).
