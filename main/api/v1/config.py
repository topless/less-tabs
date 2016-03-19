# coding: utf-8

from __future__ import absolute_import

from flask.ext import restful
from webargs.flaskparser import parser
from webargs import fields as wf
from api import helpers
import auth
import config
import model
import flask
import logging
from main import api_v1


@api_v1.resource('/config/', endpoint='api.config')
class ConfigAPI(restful.Resource):
  @auth.admin_required
  def get(self):
    return helpers.make_response(config.CONFIG_DB, model.Config.FIELDS)

  @auth.admin_required
  def post(self):
    config_db = model.Config.get_master_db()
    args = parser.parse({
      'brand_name': wf.Str(missing='gae-init'),
      'feedback_email': wf.Str(missing=None),
      'announcement_html': wf.Str(missing=None),
      'notify_on_new_user': wf.Bool(missing=False),
      'verify_email': wf.Bool(missing=False),
      'check_unique_email': wf.Bool(missing=False),
      'email_authentication': wf.Bool(missing=False),
      'analytics_id': wf.Str(missing=None),
      'anonymous_recaptcha': wf.Bool(missing=False),
    })

    for key, value in args.items():
      setattr(config_db, key, value)

    config_db.put()
    reload(config)
    return helpers.make_response(config_db, model.Config.FIELDS)
