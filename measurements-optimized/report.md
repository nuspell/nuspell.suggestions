## Suggestion test results

| metric | average | minimum | maximum |
|--------|--------:|--------:|--------:|
| Suggestion in Nuspell      | 0.747 | 0.516 | 0.974 |
| Suggestion in Hunspell     | 0.723 | 0.516 | 0.975 |
| Suggestion Speedup         | 1.5 | 0.6 | 2.2 |
| Suggestion Speedup Maximum | 4102.0 | 9.5 | 14673.2 |

The last two columns show the maximum time needed in seconds to find suggestions. Follow the links below to drill down to more metrics.

| speedup | speedup max. | dictionary | words | in Nus. | in Hun. | Max. Nus. (s) | Max. Hun. (s) 
|--------:|-------------:|------------|------:|--------:|--------:|--:|--:|
| 2.2 | 18.4 | [fr](logs/fr.out) | 288 | 0.635 | 0.653 | 1.166 | 1.922 |
| 2.1 | 9.5 | [fr-short](logs/fr-short.out) | 64 | 0.516 | 0.516 | 0.593 | 1.253 |
| 1.6 | 13742.9 | [nl](logs/nl.out) | 5232 | 0.710 | 0.684 | 2.887 | 7.321 |
| 1.5 | 14673.2 | [nl-short](logs/nl-short.out) | 256 | 0.633 | 0.578 | 2.217 | 4.032 |
| 1.1 | 85.2 | [en_US](logs/en_US.out) | 4171 | 0.974 | 0.975 | 0.475 | 0.561 |
| 1.1 | 119.5 | [en_GB](logs/en_GB.out) | 4200 | 0.963 | 0.962 | 0.828 | 0.980 |
| 0.6 | 65.5 | [de_DE_frami](logs/de_DE_frami.out) | 478 | 0.797 | 0.697 | 3.031 | 1.518 |

See also the [graphs](graphs) for more insights.
