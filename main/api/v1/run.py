# coding: utf-8

from __future__ import absolute_import

from google.appengine.ext import ndb
from flask.ext import restful
import flask

from api import helpers
import auth
import model
import util

from main import api_v1


@api_v1.resource('/run/', endpoint='api.run.list')
class RunListAPI(restful.Resource):
  def get(self):
    run_dbs, run_cursor = model.Run.get_dbs()
    return helpers.make_response(run_dbs, model.Run.FIELDS, run_cursor)


@api_v1.resource('/run/<string:run_key>/', endpoint='api.run')
class RunAPI(restful.Resource):
  def get(self, run_key):
    run_db = ndb.Key(urlsafe=run_key).get()
    if not run_db:
      helpers.make_not_found_exception('Run %s not found' % run_key)
    return helpers.make_response(run_db, model.Run.FIELDS)


###############################################################################
# Admin
###############################################################################
@api_v1.resource('/admin/run/', endpoint='api.admin.run.list')
class AdminRunListAPI(restful.Resource):
  @auth.admin_required
  def get(self):
    run_keys = util.param('run_keys', list)
    if run_keys:
      run_db_keys = [ndb.Key(urlsafe=k) for k in run_keys]
      run_dbs = ndb.get_multi(run_db_keys)
      return helpers.make_response(run_dbs, model.run.FIELDS)

    run_dbs, run_cursor = model.Run.get_dbs()
    return helpers.make_response(run_dbs, model.Run.FIELDS, run_cursor)


@api_v1.resource('/admin/run/<string:run_key>/', endpoint='api.admin.run')
class AdminRunAPI(restful.Resource):
  @auth.admin_required
  def get(self, run_key):
    run_db = ndb.Key(urlsafe=run_key).get()
    if not run_db:
      helpers.make_not_found_exception('Run %s not found' % run_key)
    return helpers.make_response(run_db, model.Run.FIELDS)
