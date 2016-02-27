#!/usr/bin/env python

import csv
import sys
from scipy.interpolate import interp1d
import matplotlib.pyplot as plt
import datetime
import dateutil.parser

dateOrd = []
data = []
with open(sys.argv[1], 'r') as file:
  reader = csv.reader(file);
  for row in reader:
    try:
      curDate = dateutil.parser.parse(row[0]).toordinal()
    except ValueError:
      continue
    if (curDate < datetime.date(2015, 10, 1).toordinal()):
      continue
    dateOrd.append(curDate)
    data.append(float(row[1]))

f = interp1d(dateOrd, data)
f2 = interp1d(dateOrd, data, kind='cubic')

moving_avg = [data[0]]
exp = 0.9
date = [datetime.date.fromordinal(dateOrd[0])]
for i in range(1, len(dateOrd)):
  moving_avg.append(moving_avg[i-1]*exp + f(dateOrd[i])*(1-exp))
  date.append(datetime.date.fromordinal(dateOrd[i]))

plt.subplots(1)[0].autofmt_xdate()
plt.plot(date,data,'o',date,f(dateOrd),'-', date, moving_avg,'--')
plt.legend(['data', 'linear', 'average'], loc='best')
plt.show()
