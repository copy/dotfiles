from IPython.core import magic
import urllib.request
import json

@magic.register_line_magic
def ddg(query):
    return ddg_client(query)

del magic
del ddg

class DuckDuckGoClient(object):

    API_URL = "https://api.duckduckgo.com/?q={q}&format=json"

    def __call__(self, query):
        req = urllib.request.urlopen(self.API_URL.format(q=query))
        response_text = req.read()
        response_text = response_text.decode("utf8")
        response = json.loads(response_text)
        import pprint
        #print(response)
        pprint.pprint(response)

ddg_client = DuckDuckGoClient()

