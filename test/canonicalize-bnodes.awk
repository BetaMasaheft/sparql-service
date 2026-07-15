# Rewrites randomly generated blank-node labels (hex hashes from the
# RDF/XML parser) to sequential ones in order of first appearance, so
# two serialisations of the same graph compare byte-equal.
# The pattern spells out "8 or more hex digits" without {8,} interval
# syntax, which mawk (Debian/Ubuntu default awk) does not support.
# "n" prefix on purpose: it is not a hex digit, so replacements can
# never re-match the pattern.
{
    while (match($0, /_:[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]*/)) {
        lbl = substr($0, RSTART, RLENGTH)
        if (!(lbl in map)) {
            map[lbl] = "_:n" ++count
        }
        $0 = substr($0, 1, RSTART - 1) map[lbl] substr($0, RSTART + RLENGTH)
    }
    print
}
