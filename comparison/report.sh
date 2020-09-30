rm -f *.md

echo '# Comparing graphs' > report.md
echo >> report.md

function report {
    echo '['$j']('$j'.md)' >> report.md
    echo >> report.md

    echo '# '$j'' > $j.md
    echo >> $j.md
    for i in $(ls *.log.$j.png|sort); do
        echo '## '$(echo $i|awk -F '.' '{print $1}') >> $j.md
        echo >> $j.md
        echo '[![]('$i')]('$i')' >> $j.md
        echo >> $j.md
    done
}

j=priv_suggest
report

j=priv_suggest_size
report

j=uppercase_suggest
report

j=map_suggest
report

j=map_suggest_attempts
report

j=adjacent_swap_suggest
report

j=keyboard_suggest
report

j=extra_char_suggest
report

j=forgotten_char_suggest
report

j=forgotten_char_suggest_attempts
report

j=move_char_suggest
report

j=bad_char_suggest
report

j=bad_char_suggest_attempts
report

j=doubled_two_chars_suggest
report

j=two_words_suggest
report

j=phonetic_suggest
report

j=priv_suggest_size
report

