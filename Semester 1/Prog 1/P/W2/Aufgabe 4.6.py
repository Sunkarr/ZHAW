# -*- coding: utf-8 -*-
"""
Created on Tue Oct  3 21:27:35 2023

@author: jonas
"""

import numpy as np
import pylab as pl
n = 256
X = np.linspace(-np.pi, np.pi, n, endpoint=True)
Ysin = np.sin(2 * X)
Ycos = np.cos(2 * X)
# pl.axes([0.025, 0.025, 0.95, 0.95])
pl.plot(X, Ysin, color='red', alpha=1.00)
pl.plot(X, Ycos, color='green', alpha=1.00)
pl.xlim([-np.pi, np.pi])
pl.ylim([-2.5, 2.5])
pl.show()


"""
Conclusion
- np.linspace zeichnet graphen np.linspacce(start, stop, num)
- np.pi ist die Konstante Pi
- es verden die Variablen: n, X, Ysin und Ycos erstellt
- pl.plot stellt die Graphen graphisch dar unter "Plots"

numpy importiert np.linspace
pylab importiert pl.plot
"""

import pdb