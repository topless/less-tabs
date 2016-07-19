# coding: utf-8

from __future__ import absolute_import

from flask.ext import restful

import flask
from api import helpers
import model

from main import api_v1


@api_v1.resource('/songs/', endpoint='api.song_list')
class SongListAPI(restful.Resource):
  def get(self):
    song_dbs, cursors = model.Song.get_dbs(prev_cursor=True)
    return helpers.make_response(song_dbs, model.Song.FIELDS, cursors)

  def post(self):
    data = flask.request.get_json()
    song_db = model.Song(
      name=data['name'].lower(),
      artist=data['by'].lower(),
      genre=data['genre'].lower(),
      harp_key=data['key'],
      harp_type=data['harp_type'],
      posted_by=data['posted_by'].lower(),
      tab=data['song'],
      harptab_id=data['harptab_id'],
    )
    song_db.put()
    return helpers.make_response(song_db, model.Song.FIELDS)


@api_v1.resource('/song/<int:song_id>', endpoint='api.song')
class SongAPI(restful.Resource):
  def get(self, song_id):
    song_db = model.Song.get_by_id(song_id)
    return helpers.make_response(song_db, model.Song.FIELDS)
