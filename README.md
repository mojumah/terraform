# terraform
infrastructure as code examples

## to generate infrastructure diagrams, first install dependencies

sudo apt install graphviz python-pydot python-pydot-ng python-pyparsing \
libcdt5 libcgraph6 libgvc6 libgvpr2 libpathplan4

## second, run the command

terraform graph | dot -Tpng > graph.png

## If on Linux, download the graph.png using scp
scp -i web_server.pem ubuntu@x.y.z.t:/home/ubuntu/terraform/terraform/graph.png .
