import axios from 'axios';
import {Repository} from "./Repository";

export const client = axios.create({
  baseURL: 'http://localhost:3000/api/v1',
  timeout: 10000,
  headers: {
    /*'X-Custom-Header': 'foobar'*/
  },
  responseType: 'json',
});


export const ServiceRepository = new Repository('/services');

