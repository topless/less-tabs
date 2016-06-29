# coding: utf-8

from __future__ import absolute_import

import flask_restful
from webargs.flaskparser import parser
from webargs import fields as wf
from marshmallow import validate
import flask

from api import helpers
import auth
import model
import task
import util
from main import api_v1
import logging


@api_v1.resource('/auth/signin/', endpoint='api.auth.signin')
class AuthSigninAPI(flask_restful.Resource):
  def post(self):
    args = parser.parse({
      'username': wf.Str(missing=None),
      'email': wf.Str(missing=None),
      'password': wf.Str(missing=None),
    })
    handler = args['username'] or args['email']
    password = args['password']
    if not handler or not password:
      return flask.abort(400)

    user_db = model.User.get_by(
      'email' if '@' in handler else 'username', handler.lower()
    )

    if user_db and user_db.password_hash == util.password_hash(user_db, password):
      auth.signin_user_db(user_db)
      return helpers.make_response(user_db, model.User.FIELDS)
    return flask.abort(401)


@api_v1.resource('/auth/signup/', endpoint='api.auth.signup')
class AuthSignupAPI(flask_restful.Resource):
  def post(self):
    try:
      args = parser.parse({
        'email': wf.Email(required=True, validator=validate.Email())
      })
    except Exception as e:
      logging.warning(e)
      return flask.abort(400)

    user_db = auth.create_user_db(
      None,
      util.create_name_from_email(args['email']),
      args['email'],
      args['email'],
    )
    user_db.put()
    task.activate_user_notification(user_db)
    return helpers.make_response(user_db, model.User.FIELDS)
