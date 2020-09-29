## Suggestion test results

| metric | average | minimum | maximum |
|--------|--------:|--------:|--------:|
| Suggestion in Nuspell      | 0.747 | 0.516 | 0.974 |
| Suggestion in Hunspell     | 0.723 | 0.516 | 0.975 |
| Suggestion Speedup         | 1.5 | 0.6 | 2.2 |
| Suggestion Speedup Maximum | 4083.0 | 9.0 | 14933.2 |

The last two columns show the maximum time needed in seconds to find suggestions. Follow the links below to drill down to more metrics.

| speedup | speedup max. | dictionary | words | in Nus. | in Hun. | Max. Nus. (s) | Max. Hun. (s) 
|--------:|-------------:|------------|------:|--------:|--------:|--:|--:|
| 2.2 | 17.8 | [fr](logs/fr.out) | 288 | 0.635 | 0.653 | 1.208 | 2.000 |
| 2.1 | 9.0 | [fr-short](logs/fr-short.out) | 64 | 0.516 | 0.516 | 0.613 | 1.309 |
| 1.6 | 13313.3 | [nl](logs/nl.out) | 5232 | 0.709 | 0.684 | 2.868 | 7.623 |
| 1.6 | 14933.2 | [nl-short](logs/nl-short.out) | 256 | 0.633 | 0.578 | 2.279 | 5.692 |
| 1.1 | 92.6 | [en_US](logs/en_US.out) | 4171 | 0.974 | 0.975 | 0.467 | 0.610 |
| 1.1 | 156.2 | [en_GB](logs/en_GB.out) | 4200 | 0.963 | 0.962 | 0.819 | 1.072 |
| 0.6 | 59.0 | [de_DE_frami](logs/de_DE_frami.out) | 478 | 0.801 | 0.697 | 3.053 | 1.588 |

See also the [graphs](graphs) for more insights.
