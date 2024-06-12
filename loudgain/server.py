import falcon
import json
import subprocess
import Path from pathlib

class ExecuteLoudgrain(object):
  companies = [{"id": 1, "name": "Company One"}, {"id": 2, "name": "Company Two"}]
  def on_get(self, req, resp):
    resp.body = json.dumps(self.companies)

app = application = falcon.App()
execute_endpoint = ExecuteLoudgrain()
app.add_route('/execute', execute_endpoint)


