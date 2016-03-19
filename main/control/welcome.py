# coding: utf-8

import flask
from flask.ext import restful

import config
import auth
import model
from main import app


###############################################################################
# All paths
###############################################################################
@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def welcome(path):
  user_db = auth.current_user_db()
  return flask.render_template(
    'index.html',
    APPLICATION_ID = config.APPLICATION_ID,
    CURRENT_VERSION_NAME = config.CURRENT_VERSION_NAME,
    config_db=restful.marshal(config.CONFIG_DB, model.Config.FIELDS),
    user_db=restful.marshal(user_db, model.User.FIELDS) if user_db else None,
  )


###############################################################################
# SSL endpoints more on https://letsencrypt.org/
###############################################################################
@app.route('/.well-known/acme-challenge/<string:challenge>')
def letsencrypt(challenge):
  response = flask.make_response('oups', 404)
  if challenge == config.CONFIG_DB.letsencrypt_challenge:
    response = flask.make_response(config.CONFIG_DB.letsencrypt_response)
  response.headers['Content-Type'] = 'text/plain'
  return response


#############################################################
# Sitemap stuff
###############################################################################
@app.route('/sitemap.xml')
def sitemap():
  response = flask.make_response(flask.render_template(
    'sitemap.xml',
    lastmod=config.CURRENT_VERSION_DATE.strftime('%Y-%m-%d'),
  ))
  response.headers['Content-Type'] = 'application/xml'
  return response


###############################################################################
# Warmup request
###############################################################################
@app.route('/_ah/warmup')
def warmup():
  # TODO: put your warmup code here
  return 'success'
