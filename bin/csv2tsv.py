#!/usr/bin/python3
import sys, os
import pandas as pd
# import time

try:
    this_csv_file = sys.argv[1]
    if os.path.exists(this_csv_file):
        print("Read csv data %s (%d kB)" % 
            (this_csv_file, os.path.getsize(this_csv_file) >> 10 ) # 10000 >> 10 = bitshift operator, to get kilo bytes (10-bits=>1024)
        )
        this_output_file="%s.tsv" % this_csv_file
        df=pd.read_csv(this_csv_file, low_memory=False)
        df.to_csv(this_output_file, sep="\t", index=False)

        print("Wrote tab separated data to %s (%d kB)" % 
            (this_output_file, os.path.getsize(this_output_file) >> 10 ) # 10000 >> 10 = bitshift operator, to get kilo bytes (10-bits=>1024)
        )
    else:
        print("File %s not found...")
        raise SystemExit(f"Usage: {sys.argv[0]} <CSV-file-to-convert>")
    
except IndexError:
    raise SystemExit(f"Usage: {sys.argv[0]} <CSV-file-to-convert>")


 
