```sh
mongo-connector -m 192.168.56.129:27017 -t 192.168.56.128:9200 -d mge_doc_manager --admin-username mongoConnector --password mongoConnector
```

## mge-doc-manager
```py
import logging

from bson import SON

try:
        import elasticsearch
except ImportError:
        raise ImportError(
                "Error: elasticsearch (https://pypi.python.org/pypi/elasticsearch) "
                "version 2.x or 5.x is not installed.\n"
                "Install with:\n"
                "  pip install elastic-doc-manager[elastic2]\n"
                "or:\n"
                "  pip install elastic-doc-manager[elastic5]\n"
        )
from elasticsearch import Elasticsearch, exceptions as es_exceptions, connection as es_connection
from elasticsearch.helpers import bulk, scan, streaming_bulk, BulkIndexError

from mongo_connector import errors, constants
from mongo_connector.compat import u
from mongo_connector.util import exception_wrapper
from mongo_connector.doc_managers.doc_manager_base import DocManagerBase

wrap_exceptions = exception_wrapper({
        BulkIndexError: errors.OperationFailed,
        es_exceptions.ConnectionError: errors.ConnectionFailed,
        es_exceptions.TransportError: errors.OperationFailed,
        es_exceptions.NotFoundError: errors.OperationFailed,
        es_exceptions.RequestError: errors.OperationFailed,})


LOG = logging.getLogger(__name__)

__version__ = constants.__version__


class DocManager(DocManagerBase):
        def __init__(self, url, **kwargs):
                if type(url) is not list:
                        url = [url]
                self.elastic = Elasticsearch(hosts=url)
                return

        def _index_and_mapping(self, namespace):
                index, doc_type = namespace.split('.', 1)
                return index.lower(), doc_type

        def stop(self):
                LOG.info("Test Done!")
                return

        def update(self, document_id, update_spec, namespace, timestamp):
                LOG.info("[UPDATE]" + str(document_id))
                return

        def upsert(self, doc, namespace, timestamp):
                index, doc_type = self._index_and_mapping(namespace)
                f_doc = {}
                for f in doc:
                        if f == '_id':
                                continue
                        else:
                                f_doc[f] = doc[f]
                self.elastic.index(index=index, doc_type=doc_type, id=doc['_id'], body=f_doc)

                return

        def bulk_upsert(self, docs, namespace, timestamp):
                return 

        def remove(self, document_id, namespace, timestamp):
                LOG.info("[REMOVE]" + str(document_id));
                return

        def insert_file(self, f, namespace, timestamp):
                return

        def search(self, start_ts, end_ts):
                return

        def commit(self):
                return

        def get_last_doc(self):
                return

```