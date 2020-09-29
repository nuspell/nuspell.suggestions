# Suggestions by Nuspell

Comparing of suggestions from Nuspell with Hunspell and reporting on suggestion
speedup and other optimizations. Optimization here means the limitation of
searching for suggestions when the maximum number of suggestions has been
reached or when certain specific suggestion methods have timed out.

# Goals

This repository has the following goals. To report on the suggestions provided
by Nuspell compared to suggestions provided with Hunspell. This is only done
for a subset of dictionaries used in verification testing for which qualitative
desirable suggestions are known.

This reporting helps analyzing how finding suggestions by Nuspell can be
optimized and what the impact of the optimization is. Once this optimization
has been fully completed, the test here can be migrated to the Nuspell
platform-independent verification repository. The main audience here are
developers and to provide preliminary figures on suggestion quality and timing.

# Organization

The main directories in this repository are `measurements-unoptimized`,
`measurements-optimized` and `measurements-optimized-nolog`. Supporting files
are stored in `dicts` for the dictionaries and `templates` for generating
histogram graphs on timings etc.

Both measurements directories have to following scripts:
- `measure-all.sh` runs all the tests in sequence
- `measure-all-parallel.sh` runs all the test in parallel
- `plot.sh` generates graphs in the `graphs` directory
- `report.py` generates an overall report called `report.md`

Note that the test run in parallel require at least an eight core CPU. The
script `measure.sh` is only to be called by the previously mentioned
measurement scripts. All measurement data is written to the `logs` directory
and files to generate the plots are written to `gnuplots`.

# Dictionaries

The dictionaries used here files that were copied from the Ubuntu 20.04
packages:

| dictionary    | package                     | version     |
|---------------|-----------------------------|-------------|
| `en_US`       | `hunspell-en-us`            | `1:6.4.3-1` |
| `en_GB`       | `hunspell-en-gb`            | `1:6.4.3-1` |
| `de_DE_frami` | `hunspell-de-de-frami`      | `1:6.4.3-1` |
| `fr`          | `hunspell-fr-comprehensive` | `1:6.4.1-1` |
| `nl`          | `hunspell-nl`               | `2:2.10-6`  |

# Test data

The test data has been compiled from the following sources:
- `en_US.tsv` from [20200907](https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_machines)
- `en_GB.tsv` from [20200907](https://en.wikipedia.org/wiki/Wikipedia:Lists_of_common_misspellings/For_machines)
- `de_DE_frami.tsv` from [20200907](http://www.frank-roesler.de/dsdr.html) and [2018](https://github.com/languagetool-org/languagetool/blob/master/languagetool-language-modules/de/src/main/java/org/languagetool/rules/de/GermanSpellerRule.java)
- `fr.tsv` from [20200907](https://fr.wikipedia.org/wiki/Faute_d%27orthographe) and 2018
- `nl.tsv` from [20200904](https://github.com/OpenTaal/opentaal-wordlist/blob/master/corrections.tsv)

Lists with corrections to investigate to perhaps include later:
- https://www.korrekturen.de/wortliste.shtml
- https://lektorat-korrekturlesen.de/fehlerwoerter

As is described in the help information of the verification executable, the test
data consists of unique word without any spaces which is incorrect for Nuspell
and Hunspell followed by a tab character and a preferred correction which is
currently spelled according to Nuspell and Hunspell. All files are in UTF-8
format and have been sorted with the `sort` command.

Compared to verification testing, where word list are mostly provided by makers
of dictionaries, here there are no sources from dictionary makers that provide
lists of errors with corrections, except for Dutch. The source for Dutch has
been filtered to contain only pair with a maximum Levenshtein distance of seven.

All TSV files are first semi-automatic altered and then heavily manually
optimized to meet the demands for suggestion testing and optimization. The file
are tab separated and contain one unique spelling error and one most likely
correction, i.e. expected first suggestion. However, the sources used were
mainly compiled by authors providing corrections for written texts with context
and without any idea of the workings of Nuspell or Hunspell. Therefore it is
not possible and also not the goal to get the preferred corrections in the
suggestions, let alone, to get them as the first suggestion. What is important
is to compare suggestions from Nuspell and Hunspell for this data and where
they are equal, where they differ and how much time was needed for that.

In the directory `measurements-unoptimized` is also a script called
`update-tsv.sh.` to update the test data for those tests. The main test data
is kept in the directory `measurements-optimized` in tab-separated value files.

The `*-short.tsv` files are shortened versions because the full versions of
those files take more than 24 hours to process in with the unoptimized software.
The shortening is done from the end of the file as all files start with words
such as

    0eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee	e
    0éééééééééééééééééééééééééééééééééééé	e
    0nononononononononononononononononono	no
    0yesyesyesyesyesyesyesyesyesyesyesyes	yes

which typically in French and Dutch trigger extremely long times for suggestion
generation in unoptimized code.

Note that suggestions are generated in many different ways, which can cause very
different times to complete. Some important factors that play a role are:
- the suggestion tactic; which suggestion method is tried when
- the suggestion technique; some have another order processing power needed
- the dictionary; suffixing, compounding, TRY, KEY, MAP, etc.
- the word to find suggestions for; length, characters used

# Prerequisites

Before any tests are run, install the following:

    sudo apt-get install gnuplot

In `measurement-unoptimized`, place a version of the Nuspell source tree which
does not have optimized suggestions, e.g.
https://github.com/nuspell/nuspell/commit/d612c36615f36ab74b12fdfd1737f146b6ddaec9
 . It does need extra code to report on timings, see the `patch` directory.
There are altered versions for dictionary source code. Additionally it needs a
version of the following files verification testing with similar metric
reporting output (see optimized branch below):
- `CMakeLists.txt`
- `tests/CMakeLists.txt`
- `tests/verifify.cxx`
- `src/nuspell/CMakeLists.txt`

Then build Nuspell with:

    cd nuspell
    mkdir build && cd build
    cmake -DBUILD_TIMING=ON .. && make -j && make test
    cd ../..

In `measurement-optimized`, place a branch of Nuspell where suggestions are
optimized that includes similar lines for reporting the same metrics. It needs
to be build with the same commands. Note, when the optimization has been
completed, the reporting of these metrics are no longer relevant, only the
numbers that are reported by the verification executable.

In `measurement-optimized-nolog` is identical to `measurement-optimized` but
without the build option `-DBUILD_TIMING=ON`. This prevents writing metrics to
log files and will provide more accurate overall speedup times, but no insight
into suggestion methods. Spoiler: in verification testing the speedup varies
slightly with each test, in the second decimal. Suggestion testing uses timeouts
and is therefore more prone to variations. Hence disabling the metric logging
will probably have a marginally effect or disappear in the timing variation.

# Optimization

The optimization used implements task 1. and 3. of
https://github.com/nuspell/nuspell/issues/45 See the specific Nuspell branch for
details.

The timeout in the optimization is currently set to 5,000,000 nanoseconds. Using
half of that only results in a marginal improvement of speedup but degrades the
quality and number of suggestions returned. During development, also other
values for timeout were tested, but this is currently the optimal value.

Maximum word length in Hunspell is set to 100, but in Nuspell this is set to
180. Reducing this to 100 increases speedup and suggestion quality marginally.
This is something that could be investigated further later and maximum word
length in Nuspell stays at 180.

# Output

The special builds of Nuspell provide timings per specific suggestion method,
for the total suggestion method, how many attempts in certain suggestions
methods were done and the number of suggestions that got returned. This is
split off into several specific log files from which graphs are made with the
`plot.sh` script. See
[measurements-unoptimized/graphs](measurements-unoptimized/graphs) and
[measurements-optimized/graphs](measurements-optimized/graphs). Titles of the
graphs and their file names refer to specific and overall suggestion methods
in the `dictionary.cxx` source file. Note that certain methods can be called in
total more often than the number of words provided by a test.

The verification itself also reports on times and other metrics which are
aggregated by the `report.py` script, see
[measurements-unoptimized/report.md](measurements-unoptimized/report.md),
[measurements-optimized/report.md](measurements-optimized/report.md) and
[measurements-optimized-nologs/report.md](measurements-optimized-nologs/report.md).
Here also a drill down to more details is offered.

As these tests compare Nuspell and Hunspell, the developer or analyst needs to
compare the reports and graphs side by side to get more insight impact is of the
optimization. In the overall number, clearly can be seen that these
optimizations have a huge impact on the usability of Nuspell's suggestions.

The table below provides typical run times for the test and justifying
shortening the tests for French and Dutch for the unoptimized code and at the
same time, as the numbers in the report and output files illustrating the
importance of suggestion optimization that is not apparent from testing with
English dictionaries alone.

| test / dict     | en_US | en_GB | de_DE_frami | fr     | fr-short |  nl    | nl-short |
|-----------------|------:|------:|------------:|-------:|---------:|-------:|---------:|
| unoptimized     | 17 m. | 34 m. |        8 m. | >24 h. |   205 m. | >24 h. |    57 m. |
| optimized       | 14 m. | 25 m. |        6 m. |   4 m. |     1 m. |  67 m. |     4 m. |
| optimized-nolog | 14 m. | 25 m. |        6 m. |   4 m. |     1 m. |  67 m. |     4 m. |

Note that currently `fr-short.tsv` is the last 64 lines of `fr.tsv` and that
`nl-short.tsv` is the last 256 lines of `nl.tsv`. All typical processing times
here are from an i7-10510U CPU @ 1.80GHz. Once again, these run times are only
additional. See the reports and graphs for actual metrics.

