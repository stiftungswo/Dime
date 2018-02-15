import {client} from "./api";
import moment from "moment";

export const createDateEnricher = (dates) => (entity) =>
  dates.reduce((e, field) => {
    e[field] = moment(e[field]);
    return e;
  } ,entity)

const defaultClone = (entity) => ({
  ...this.unenrich(entity),
  id: undefined
})

const identity = (i) => i;

export class Repository{
  constructor(baseUrl, {
    enrich = identity,
    unenrich = identity,
    clone = defaultClone,
  } = {})
  {
    this.baseUrl = baseUrl;
    this.enrich = enrich;
    this.unenrich = unenrich;
    this.clone = clone;
  }

  one = (id) => client.get(this.baseUrl + '/' + id)
    .then(res => this.enrich(res.data))

  list = () => client.get(this.baseUrl)
    .then(res => res.data.map(this.enrich))

  save = (entity, {id = null} = {}) => client.put(
    this.baseUrl + '/' + (id || entity.id),
    this.unenrich(entity)
  )

  clone = (entity) => client.post(this.baseUrl, this.clone(entity))

}