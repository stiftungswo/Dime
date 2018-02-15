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

  one = (id) => client({path: this.baseUrl + '/' + id})
    .then(res => this.enrich(res.entity))

  list = () => client({path: this.baseUrl})
    .then(res => res.entity.map(this.enrich))

  save = (entity, {id = null} = {}) => client({
    path: this.baseUrl + '/' + (id || entity.id),
    method: 'PUT',
    entity: this.unenrich(entity),
  })

  clone = (entity) => client({
    path: this.baseUrl,
    method: 'POST',
    entity: this.clone(entity)
  })

}