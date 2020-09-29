## Suggestion test results

| metric | average | minimum | maximum |
|--------|--------:|--------:|--------:|
| Suggestion in Nuspell      | 0.786 | 0.516 | 0.974 |
| Suggestion in Hunspell     | 0.745 | 0.516 | 0.975 |
| Suggestion Speedup         | 0.5 | 0.0 | 1.1 |
| Suggestion Speedup Maximum | 3246.8 | 0.9 | 16174.0 |

The last two columns show the maximum time needed in seconds to find suggestions. Follow the links below to drill down to more metrics.

| speedup | speedup max. | dictionary | words | in Nus. | in Hun. | Max. Nus. (s) | Max. Hun. (s) 
|--------:|-------------:|------------|------:|--------:|--------:|--:|--:|
| 1.1 | 32.6 | [en_US](logs/en_US.out) | 4171 | 0.974 | 0.975 | 0.445 | 0.524 |
| 1.1 | 1.5 | [en_GB](logs/en_GB.out) | 4200 | 0.963 | 0.962 | 0.784 | 0.880 |
| 0.5 | 25.1 | [de_DE_frami](logs/de_DE_frami.out) | 478 | 0.835 | 0.697 | 2.880 | 1.026 |
| 0.0 | 16174.0 | [nl-short](logs/nl-short.out) | 256 | 0.645 | 0.578 | 2773.887 | 4.093 |
| 0.0 | 0.9 | [fr-short](logs/fr-short.out) | 64 | 0.516 | 0.516 | 6971.167 | 0.905 |

See also the [graphs](graphs) for more insights.
