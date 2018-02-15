import {Repository} from "./Repository";

const rest = require('rest');
const mime = require('rest/interceptor/mime');
const auth = require('rest/interceptor/basicAuth')
const pathPrefix = require('rest/interceptor/pathPrefix')

export const client = rest
  .wrap(mime, {mime: "application/json"})
  .wrap(auth, {username: 'admin', password: 'admin'})
  .wrap(pathPrefix, {prefix: 'http://localhost:3000/api/v1'})


export const ServiceRepository = new Repository('/services');

