## Suggestion test results

| metric | average | minimum | maximum |
|--------|--------:|--------:|--------:|
| Suggestion in Nuspell      | 0.786 | 0.516 | 0.974 |
| Suggestion in Hunspell     | 0.745 | 0.516 | 0.975 |
| Suggestion Speedup         | 0.5 | 0.0 | 1.1 |
| Suggestion Speedup Maximum | 3026.1 | 0.9 | 15071.4 |

The last two columns show the maximum time needed in seconds to find suggestions. Follow the links below to drill down to more metrics.

| speedup | speedup max. | dictionary | words | in Nus. | in Hun. | Max. Nus. (s) | Max. Hun. (s) 
|--------:|-------------:|------------|------:|--------:|--------:|--:|--:|
| 1.1 | 31.2 | [en_US](logs/en_US.out) | 4171 | 0.974 | 0.975 | 0.279 | 0.340 |
| 1.1 | 1.8 | [en_GB](logs/en_GB.out) | 4200 | 0.963 | 0.962 | 0.755 | 0.866 |
| 0.5 | 25.1 | [de_DE_frami](logs/de_DE_frami.out) | 478 | 0.835 | 0.697 | 2.788 | 1.000 |
| 0.0 | 15071.4 | [nl-short](logs/nl-short.out) | 256 | 0.645 | 0.578 | 2856.211 | 5.431 |
| 0.0 | 0.9 | [fr-short](logs/fr-short.out) | 64 | 0.516 | 0.516 | 6550.860 | 1.008 |

See also the [graphs](graphs) for more insights.
