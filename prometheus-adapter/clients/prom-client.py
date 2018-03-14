from prometheus_client import CollectorRegistry, Gauge, push_to_gateway

registry = CollectorRegistry()
g = Gauge('fabio_time', 'Last time for fabio', registry=registry)
g.set_to_current_time()
push_to_gateway('192.168.192.190:9091', job='batchA', registry=registry)
