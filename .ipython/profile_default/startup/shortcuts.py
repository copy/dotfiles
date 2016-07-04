from IPython.core import magic
import os

@magic.register_line_magic
def df(query):
    return os.system("df " + query)

@magic.register_line_magic
def feh(query):
    return os.system("feh " + query)

@magic.register_line_magic
def mutt(query):
    return os.system("mutt")

@magic.register_line_magic
def cmus(query):
    return os.system("cmus")

@magic.register_line_magic
def free(query):
    return os.system("free " + query)

@magic.register_line_magic
def vlc(query):
    return os.system("vlc " + query)

del df
del feh
del mutt
del cmus
del magic
del free
del vlc
