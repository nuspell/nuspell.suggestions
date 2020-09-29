#!/usr/bin/env python3
'''Reporting suggestion testing'''

__author__ = 'Sander van Geloven'
__license__ = 'https://github.com/nuspell/nuspell/blob/master/COPYING.LESSER'

from operator import itemgetter
from os import listdir, path
import sys

def main():
    '''Report verification in MarkDown file with links'''
    print('INFO: Report')

    # Read log files
    results = []
    min_in_nu = sys.float_info.max
    min_in_hun = sys.float_info.max
    min_speedup = sys.float_info.max
    min_speedup_max = sys.float_info.max
    max_in_nu = 0.0
    max_in_hun = 0.0
    max_speedup = 0.0
    max_speedup_max = 0.0
    ave_in_nu = 0.0
    ave_in_hun = 0.0
    ave_speedup = 0.0
    ave_speedup_max = 0.0
    for file in sorted(listdir('logs')):
        if file.endswith('.log'):
            dikt = file[:-4]
            print(f'  {dikt}')
            result = open(path.join('logs', file))
            words = None
            max_nu = None
            max_hun = None
            in_nu = None
            in_hun = None
            speedup = None
            speedup_max = None
            for line in result:
                line = line.strip()
                if line.startswith('Total Words Suggestion'):
                    words = line.split(' ')[-1]
                if line.startswith('Maximum Duration Suggestions Nuspell'):
                    max_nu = line.split(' ')[-1]
                if line.startswith('Maximum Duration Suggestions Hunspell'):
                    max_hun = line.split(' ')[-1]
                elif line.startswith('Rate Corr. In Suggestions Nuspell'):
                    in_nu = float(line.split(' ')[-1])
                    ave_in_nu += in_nu
                    if in_nu < min_in_nu:
                        min_in_nu = in_nu
                    if in_nu > max_in_nu:
                        max_in_nu = in_nu
                elif line.startswith('Rate Corr. In Suggestions Hunspell'):
                    in_hun = float(line.split(' ')[-1])
                    ave_in_hun += in_hun
                    if in_hun < min_in_hun:
                        min_in_hun = in_hun
                    if in_hun > max_in_hun:
                        max_in_hun = in_hun
                elif line.startswith('Suggestions Speedup'):
                    speedup = float(line.split(' ')[-1])
                    ave_speedup += speedup
                    if speedup < min_speedup:
                        min_speedup = speedup
                    if speedup > max_speedup:
                        max_speedup = speedup
                elif line.startswith('Maximum Suggestions Speedup'):
                    speedup_max = float(line.split(' ')[-1])
                    ave_speedup_max += speedup_max
                    if speedup_max < min_speedup_max:
                        min_speedup_max = speedup_max
                    if speedup_max > max_speedup_max:
                        max_speedup_max = speedup_max
            results.append({'d':dikt, 'w':words, 'mn':max_nu, 'mh':max_hun,
                            'in':in_nu, 'ih':in_hun, 's':speedup,
                            'm':speedup_max})

    ave_in_nu /= len(results)
    ave_in_hun /= len(results)
    ave_speedup /= len(results)
    ave_speedup_max /= len(results)

    output = open('report.md', 'w')

    output.write('## Suggestion test results\n')

    output.write('\n')
    output.write('| metric | average | minimum | maximum |\n')
    output.write('|--------|--------:|--------:|--------:|\n')
    output.write('| Suggestion in Nuspell      | {:.3f} | {:.3f} | {:.3f} |\n'
                 .format(ave_in_nu, min_in_nu, max_in_nu))
    output.write('| Suggestion in Hunspell     | {:.3f} | {:.3f} | {:.3f} |\n'
                 .format(ave_in_hun, min_in_hun, max_in_hun))
    output.write('| Suggestion Speedup         | {:.1f} | {:.1f} | {:.1f} |\n'
                 .format(ave_speedup, min_speedup, max_speedup))
    output.write('| Suggestion Speedup Maximum | {:.1f} | {:.1f} | {:.1f} |\n'
                 .format(ave_speedup_max, min_speedup_max, max_speedup_max))

    output.write('\n')
    output.write('The last two columns show the maximum time needed in' \
                 ' seconds to find suggestions. Follow the links below' \
                 ' to drill down to more metrics.\n')

    output.write('\n')
    output.write('| speedup | speedup max. | dictionary | words |' \
                 ' in Nus. | in Hun. | Max. Nus. (s) | Max. Hun. (s) \n')
    output.write('|--------:|-------------:|------------|------:|' \
                 '--------:|--------:|--:|--:|\n')
    results = sorted(results, key=itemgetter('s'), reverse=True)
    for result in results:
        dikt = result['d']
        word = result['w']
        max_nu = result['mn']
        max_hun = result['mh']
        in_nu = result['in']
        in_hun = result['ih']
        spee = result['s']
        maxs = result['m']
        output.write('| {:.1f} | {:.1f} | [{}](logs/{}.out) | {} |' \
                     ' {:.3f} | {:.3f} | {:.3f} | {:.3f} |\n'
                     .format(spee, maxs, dikt, dikt, word, in_nu, in_hun,
                             float(max_nu)/1E9, float(max_hun)/1E9))

    output.write('\n')
    output.write('See also the [graphs](graphs) for more insights.\n')


if __name__ == "__main__":
    main()
