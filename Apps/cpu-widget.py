import psutil
import sys

print("." * 16)
sys.stdout.flush()

r = " ▁▂▃▄▅▆▇█"

def as_ramp(v):
    global r
    return r[round((v / 100) * len(r))]

while True:
    load = psutil.cpu_percent(3, percpu=True)
    avg = sum(load) / len(load)
    if avg < 40:
        color = ""
    elif avg < 70:
        color = "fgcolor=\"#dbb651\""
    else:
        color = "fgcolor=\"#e75a7c\""
    print(f"<span {color}>", *[as_ramp(x) for x in load], "</span>", sep="")
    sys.stdout.flush()
