#!/usr/bin/env python
scorelist = map(int,raw_input().split())
worst_record_broken = 0
best_record_broken = 0
count = 0
scorelist_lenth = len(list(scorelist))-1

temp_first = scorelist[count]
temp_second = scorelist[count]
count = count + 1
for check in scorelist:
    if count < scorelist_lenth:
       if temp_first < scorelist[int(count)]:
           temp_first = scorelist[int(count)]
           best_record_broken = best_record_broken + 1

       if temp_second > scorelist[int(count)]:
           temp_second = scorelist[int(count)]
           worst_record_broken = int(worst_record_broken) + 1

    count = count + 1

print "Best record broken:", best_record_broken, "times"
print "Worst record Broken:", worst_record_broken, "times"
