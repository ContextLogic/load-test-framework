## Summary
This repo is for demo purpose for load testing with the usage of [locust](https://docs.locust.io/en/stable/what-is-locust.html) framework, which holding a open sourced license under MIT license.

Here I am only focus on showing its basic usage. You can see more use cases by going to its official website or simply google around.

## Installation
First of first, everything are supposed to be run under Python 3. Python 2 may also work, but not recommended.
```
$ pip3 install locust
```
And here are other dependencies for running this example
```
$ pip3 install torch torchvision torchaudio
$ pip3 install -i https://pypi.infra.wish.com/simple/ coeus_model_registry_client
```

## Example running guide
Firstly, `cd` into the demo folder, then build a local server:
```
$ cd demo
$ go build golang/example_server.go
```
Then open another terminal, run the server:
```
$ ./example_server
```
Finally, start locust and you will see:
```
$ locust -f locustfile.py --host=http://localhost:8080

creating client with cert
[2021-11-05 13:20:06,388] shchen-mac/INFO/locust.main: Starting web interface at http://0.0.0.0:8089 (accepting connections from all network interfaces)
[2021-11-05 13:20:06,403] shchen-mac/INFO/locust.main: Starting Locust 2.5.0
```
Now you can open your favourite browser, input `http://0.0.0.0:8089` and see Locust panel. By setting up user and spawn rate, you will simply start playing with. 

If you don't want a WebUI but pure console output instead, the option for you is to run this command instead:
```
$ locust --headless --users 1 --spawn-rate 1 -f locustfile.py --host=http://localhost:8080
```

And now everything will be in output:
```
...
 Name                                                                              # reqs      # fails  |     Avg     Min     Max  Median  |   req/s failures/s
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 POST /api/users                                                                        5     0(0.00%)  |     463     404     633     430  |    1.25    0.00
 GET /entries                                                                           3     0(0.00%)  |     540     324     918     380  |    0.75    0.00
 GET /profile                                                                           4     0(0.00%)  |       3       2       4       3  |    1.00    0.00
 GET /shujie                                                                            1   1(100.00%)  |      59      59      59      59  |    0.25    0.25
----------------------------------------------------------------------------------------------------------------------------------------------------------------
 Aggregated                                                                            13     1(7.69%)  |     308       2     918     380  |    3.24    0.25

Response time percentiles (approximated)
 Type     Name                                                                                  50%    66%    75%    80%    90%    95%    98%    99%  99.9% 99.99%   100% # reqs
--------|--------------------------------------------------------------------------------|---------|------|------|------|------|------|------|------|------|------|------|------|
 POST     /api/users                                                                            430    440    440    630    630    630    630    630    630    630    630      5
 GET      /entries                                                                              380    380    920    920    920    920    920    920    920    920    920      3
 GET      /profile                                                                                3      3      4      4      4      4      4      4      4      4      4      4
 GET      /shujie                                                                                60     60     60     60     60     60     60     60     60     60     60      1
--------|--------------------------------------------------------------------------------|---------|------|------|------|------|------|------|------|------|------|------|------|
 None     Aggregated
 ...
```

## Optional: explain on the example
I think the [quickstart](https://docs.locust.io/en/stable/quickstart.html) offered by locust explains better than me, but I will pick up some key points.

The core of locust is `locustfile.py`, where we placed all the test cases there. Let's see the base template:
```
class HelloWorldUser(HttpUser):
    @task(2)
    def api_call_A(self):
        ...

    @task(3)
    def api_call_B(self):
        ...
```
All the methods under the class inherited from `HttpUser` with the notation `@task` will be regarded as an API call that you will be interested in, and Locust will take it. Otherwise, the method will not be taken as a task and Locust won't care about it. 

All the API will be called in parallel, and the numbers controls the ratio of API calls in one round. For example `@task(2) @task(3)` is saying that the API calls should be in a ratio of 2:3, so you should expect whenever you see 2 `api_call_A()`, there should be 3 `api_call_B()` followed. 

Another thing you may notice is that, we are using two different clients here: `self.client` and `coeus`. The former is native client offered by Locust, and the latter is our own client. For the `self.client`, Locust is smart enough to catch the request type (POST, GET, etc.) and name (API endpoint) on the panel or consle. It's appropriate for testing the general APIs. 

For users' own client, we have to fire the event by ourselves. For example, here I use
```
events.request_success.fire(request_type="coeus", name="registry", response_time=0, response_length=0)
```
Of course, there also exists failure version:
```
events.request_failure.fire(request_type=name, name=cmd, response_time=total_time, exception=e)
```