# coding: utf-8

from __future__ import absolute_import

from google.appengine.ext import ndb
from google.appengine.api import search
from google.appengine.ext import deferred

import flask
import flask_restful
from api import helpers
import model
import config
import util
from main import api_v1

_INDEX_NAME = 'song_search'


@api_v1.resource('/search/', endpoint='api.search')
class SearchAPI(flask_restful.Resource):
  def get(self):
    query_str = ' AND '.join(util.param('search').split())
    query = "name:{0} OR artist: {0}".format(query_str)
    options = search.QueryOptions(
      limit=util.param('limit', int) or config.DEFAULT_DB_LIMIT,
    )

    results = search.Index(name=_INDEX_NAME).search(search.Query(
      query_string=query,
      options=options
    ))

    song_keys = [ndb.Key(urlsafe=res.doc_id) for res in results.results]
    song_dbs = ndb.get_multi(song_keys)
    return helpers.make_response(song_dbs, model.Song.FIELDS)


@api_v1.resource('/search/create', endpoint='api.search.indexes')
class SearchIndexesAPI(flask_restful.Resource):
  def post(self):
    deferred.defer(create_documents)
    return flask.jsonify({
      'result': 'The queues started patching all run models!!',
      'status': 'success'
    })


def create_documents(next_cursor=None):
  index = search.Index(name=_INDEX_NAME)
  song_dbs, next_cursor = util.get_dbs(model.Song.query(), cursor=next_cursor)
  if song_dbs:
    for song_db in song_dbs:
      document = search.Document(
        doc_id=song_db.key.urlsafe(),
        fields=[
          search.TextField(name='name', value=song_db.name),
          search.TextField(name='artist', value=song_db.artist),
        ])
      index.put(document)

  if next_cursor['next'] is not None:
    deferred.defer(create_documents, next_cursor['next'])
