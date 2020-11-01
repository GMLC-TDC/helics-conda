# -*- coding: utf-8 -*-
try:
    import helics as h

    print(h.helicsGetVersion())
except Exception as e:
    print(e)
    pass
