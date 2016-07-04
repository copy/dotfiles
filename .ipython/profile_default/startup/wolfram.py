"""
    A Wolfram Alpha ipython client.

    Installation:
        1. Put this script into ~/.ipython/profile_default/startup/
        2. pip install wolframalpha colorama
        3. Get an API key from https://developer.wolframalpha.com/portal/myapps/ and put it into ~/.wolfram_key

    Example:
        In [1]: wa jacobisymbol[31,37]
        Input: (31/37)
        Result: -1

        In [2]: wa ocelot
        Input interpretation: ocelot  (animal)
        Scientific name: Leopardus pardalis
        [...]
"""

from IPython.core import magic

@magic.register_line_magic
def wa(query):
    return wa_client(query)

del magic
del wa


class WolframAlphaClient(object):

    APPID_FILE = "~/.wolfram_key"

    def __init__(self):
        self.client = None
        self.colorama = None

    def lazy_init(self):
        if self.client is not None:
            return

        import wolframalpha
        import os
        appid = open(os.path.expanduser(self.APPID_FILE)).read().strip()

        self.client = wolframalpha.Client(appid)

        import colorama
        self.colorama = colorama
        self.colorama.init()

    def indent(self, text, width=4):
        def indent_single(t):
            if t:
                return width * " " + t
            else:
                return ""
        return "\n".join(indent_single(t) for t in text.split("\n"))

    def __call__(self, query):
        self.lazy_init()

        result = self.client.query(query)

        for pod in result.pods:
            color = self.colorama.Fore.GREEN + self.colorama.Style.BRIGHT
            color_end = self.colorama.Style.RESET_ALL

            #print("====", pod.title)
            #print(repr(pod.text))
            #print(repr(pod.id))
            #print(repr(pod.numsubpods))
            #print(repr(pod.scanner))
            #print(repr(pod.position))
            #print(repr(pod.main))
            text = str(pod.text)

            #print(dir(pod))
            #print(repr(pod.text))
            title = pod.title

            if title == "Clocks":
                # fix broken result
                text = text.replace("               ", "\n\n")

            if "\n" in text:
                text = "\n" + self.indent(text)
            else:
                text = pod.text

            print("%s%s%s: %s" % (color, pod.title, color_end, text))

        print()

        return result


wa_client = WolframAlphaClient()


