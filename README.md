# magento2-fingerprint-states

The fingerprintable subtree sets of Magento Open Source 2 and Mage-OS
release tags, one commit per tag — a thin pinned mirror built for the
strix fingerprint corpus (alexander-voronkov/strix PR #108, issue #60).

## Why

A materialised Magento 2 tag tree is ~370 MB / 42k files, but the
corpus reads only `lib/web`, `app/design/frontend`, `pub/errors` and
the module `view/(frontend|base)/web` statics (~1.9k files, ~35-60 MB).
Fetching 94 full trees filled a GitHub runner's disk twice (measured);
this mirror carries the same 94 states as 94 commits in a ~17 MiB pack
(git deduplicates the bytes adjacent states share).

## Provenance

Every commit message names the vendor repository, tag and PEELED commit
it was extracted from; `extract.sh` (kept at the root, next to this
README) is the exact extractor. The content is byte-identical to the
vendor tree on the extracted paths:

- `magento2/<tag>` commits <- https://github.com/magento/magento2
- `mageos/<tag>`   commits <- https://github.com/mage-os/mageos-magento2

Licences unchanged at the source: OSL-3.0 (+ module-level AFL-3.0
parts). This mirror exists for hash fingerprinting; nothing here is
redistributed beyond the public upstream bytes.
