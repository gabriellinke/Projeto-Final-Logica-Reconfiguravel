import sys
with open(sys.argv[1], mode="r") as f, open("output.txt", 'w') as out:
    for line in f:
        paren = False
        for c in line:
            if c == "(":
                paren = True
            elif c == ")":
                paren = False
                out.write("\r\n")
            elif paren:
                out.write(c)
