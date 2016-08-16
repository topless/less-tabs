# coding: utf-8

from __future__ import absolute_import

from google.appengine.api import search
from google.appengine.ext import deferred

import flask
import flask_restful
import model
import util
from main import api_v1

import logging

_INDEX_NAME = 'song_search'


@api_v1.resource('/search/', endpoint='api.search')
class SearchAPI(flask_restful.Resource):
  def get(self):
    logging.warning(util.param('search'))
    query = "name:{}".format(util.param('search'))
    results = search.Index(name=_INDEX_NAME, namespace='default').search(search.Query(query_string=query))
    logging.warning(results.results)
    return flask.jsonify({
      'search_result': len(results.results),
    })


@api_v1.resource('/search/create', endpoint='api.search.indexes')
class SearchIndexesAPI(flask_restful.Resource):
  def get(self):
    logging.warning("CReating indexes")
    deferred.defer(create_documents)
    index = create_documents()
    return flask.jsonify({
      'result': 'The queues started patching all run models!!',
      'status': 'success',
      'index': index
    })


def tokenize_autocomplete(phrase):
  result = []
  for word in phrase.split():
    j = 1
    while True:
      for i in range(len(word) - j + 1):
        result.append(word[i:i + j])
        if j == len(word):
          break
        j += 1
  return result


def create_documents(next_cursor=None):
  index = search.Index(name=_INDEX_NAME)
  song_dbs, next_cursor = util.get_dbs(model.Song.query(), cursor=next_cursor)
  if song_dbs:
    for song_db in song_dbs:
      name = ','.join(tokenize_autocomplete(song_db.name))
      artist = ','.join(tokenize_autocomplete(song_db.artist))
      document = search.Document(
        doc_id=song_db.key.urlsafe(),
        fields=[
          search.TextField(name='name', value=name),
          search.TextField(name='artist', value=artist),
        ])
      logging.warning('Song indexed')
      index.put(document)
  logging.warning("Patched %d entities." % len(song_dbs))
  if next_cursor['next'] is not None:
    deferred.defer(create_documents, next_cursor['next'])
  return index
