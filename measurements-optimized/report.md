## Suggestion test results

| metric | average | minimum | maximum |
|--------|--------:|--------:|--------:|
| Suggestion in Nuspell      | 0.748 | 0.516 | 0.974 |
| Suggestion in Hunspell     | 0.723 | 0.516 | 0.975 |
| Suggestion Speedup         | 1.6 | 0.6 | 2.9 |
| Suggestion Speedup Maximum | 4361.3 | 10.9 | 15396.2 |

The last two columns show the maximum time needed in seconds to find suggestions. Follow the links below to drill down to more metrics.

| speedup | speedup max. | dictionary | words | in Nus. | in Hun. | Max. Nus. (s) | Max. Hun. (s) 
|--------:|-------------:|------------|------:|--------:|--------:|--:|--:|
| 2.9 | 10.9 | [fr-short](logs/fr-short.out) | 64 | 0.516 | 0.516 | 0.276 | 0.848 |
| 2.3 | 18.5 | [fr](logs/fr.out) | 288 | 0.635 | 0.653 | 0.980 | 1.639 |
| 1.6 | 14846.2 | [nl](logs/nl.out) | 5232 | 0.709 | 0.684 | 3.801 | 10.180 |
| 1.6 | 15396.2 | [nl-short](logs/nl-short.out) | 256 | 0.633 | 0.578 | 2.067 | 5.228 |
| 1.1 | 81.3 | [en_US](logs/en_US.out) | 4171 | 0.974 | 0.975 | 0.446 | 0.518 |
| 1.1 | 119.8 | [en_GB](logs/en_GB.out) | 4200 | 0.963 | 0.962 | 0.706 | 0.868 |
| 0.6 | 56.4 | [de_DE_frami](logs/de_DE_frami.out) | 478 | 0.803 | 0.697 | 1.710 | 1.069 |

See also the [graphs](graphs) for more insights.
