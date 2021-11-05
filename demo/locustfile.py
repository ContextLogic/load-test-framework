from contextlib import contextmanager
from locust import HttpUser, task, events
from coeus_model_registry_client import ModelRegistryClient
import json
import time
import sys, os

@contextmanager
def suppress_stdout():
    with open(os.devnull, "w") as devnull:
        old_stdout = sys.stdout
        sys.stdout = devnull
        try:  
            yield
        finally:
            sys.stdout = old_stdout
coeus = ModelRegistryClient()

class HelloWorldUser(HttpUser):
    # # local API
    # @task(4)
    # def hello_world(self):
    #     self.client.get("/profile")

    # # public get API
    # @task(2)
    # def hello_external_get(self):
    #     self.client.get("https://api.publicapis.org/entries")
    
    # # public post API
    # # https://reqres.in/
    # @task(3)
    # def hello_external_post(self):
    #     self.client.post("https://reqres.in/api/users", data=json.dumps({
    #         "name": "mafty_navue_erin",
    #         "job": "botanist"
    #     }))

    # # a fake API
    # @task
    # def hello_non_existing(self):
    #     self.client.get("https://shujie.edu/shujie")

    @task
    def hello_coeus(self):
        # with suppress_stdout():
        RPS = 1.0
        models = coeus.get_models('default')
        print(models)
        events.request_success.fire(request_type="coeus", name="registry", response_time=0, response_length=0)
        request_ts = (1.0/RPS)
        time.sleep(request_ts)
