from pymongo import MongoClient
from django.conf import settings

try:
    import dns.resolver
    dns.resolver.default_resolver = dns.resolver.Resolver(configure=False)
    dns.resolver.default_resolver.nameservers = ['8.8.8.8', '8.8.4.4', '1.1.1.1']
except Exception:
    pass

def get_db():
    client = MongoClient(settings.MONGO_URI)
    return client[settings.MONGO_DB_NAME]
