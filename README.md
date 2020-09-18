# Interactive Katacoda Scenarios

[![](http://shields.katacoda.com/katacoda/cypggs/count.svg)](https://www.katacoda.com/cypggs "Get your profile on Katacoda.com")

Visit https://www.katacoda.com/helm3 to view the profile and interactive scenarios

### Writing Scenarios
Visit https://www.katacoda.com/docs to learn more about creating Katacoda scenarios

For examples, visit https://github.com/katacoda/scenario-example

https://katacoda.com/scenario-examples/scenarios/dashboard-tabs-iframe

"environment": {
    "showdashboard": true,
    "dashboards": [{"name": "URL", "href": "https://www.katacoda.com"},
        {"name": "Port 80", "port": 80},
        {"name": "Placeholder", "href": "https://[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com"}],
    "uilayout": "terminal-iframe"
}
