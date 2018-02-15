import React, { Component } from 'react';
import {Link} from "react-router-dom";
import {ServiceRepository} from "./api/api";

const limit = (text) => {
  if(text && text.length > 100){
    return text.substr(0,100) + "..."
  }
  return text;
}

export class ServiceOverview extends Component{
  constructor(props){
    super(props);
    this.state = {
      entities: []
    }
  }

  componentWillMount = () => this.reload();

  reload = async () => {
    const entities = await ServiceRepository.list();
    this.setState({entities});
  }

  render = () => {
    return (
      <div className="box box-primary">
        <div className="box-header with-border">
          <h3 className="box-title">Services</h3>
        </div>
        <div className="box-body">
          <div className="form-group">
            <input type="text" className="form-control" placeholder="Suche" ng-model="filterString"/>
          </div>
          <table className="table table-bordered table-hover">
            <thead>
            <tr>
              <th width="50">
                <a ng-click="changeSortOrder('id')">
                  ID<span ng-show="sortType == 'id' && sortReverse" className="fa fa-fw fa-angle-up"></span><span ng-show="sortType == 'id' && !sortReverse" className="fa fa-fw fa-angle-down"></span>
                </a>
              </th>
              <th>
                <a ng-click="changeSortOrder('name')">
                  Name<span ng-show="sortType == 'name' && sortReverse" className="fa fa-fw fa-angle-up"></span><span ng-show="sortType == 'name' && !sortReverse" className="fa fa-fw fa-angle-down"></span>
                </a>
              </th>
              <th>
                <a ng-click="changeSortOrder('alias')">
                  Alias<span ng-show="sortType == 'alias' && sortReverse" className="fa fa-fw fa-angle-up"></span><span ng-show="sortType == 'alias' && !sortReverse" className="fa fa-fw fa-angle-down"></span>
                </a>
              </th>
              <th>
                <a ng-click="changeSortOrder('description')">
                  Beschreibung<span ng-show="sortType == 'description' && sortReverse" className="fa fa-fw fa-angle-up"></span><span ng-show="sortType == 'description' && !sortReverse" className="fa fa-fw fa-angle-down"></span>
                </a>
              </th>
              <th width="110">Aktion</th>
            </tr>
            </thead>
            <tbody ng-if="entities != null">
              {this.state.entities.map(service =>
              <tr key={service.id}>
                <td>{service.id}</td>
                <td>{service.name} {service.archived ? <span className="text-muted">[ARCHIVIERT]</span>: null}</td>
                <td>{service.alias}</td>
                <td>{limit(service.description)}</td>
                <td>
                  <div className="btn-group">
                    <Link to={`/services/${service.id}`}>EDIT</Link>
                    <button type="button" className="btn btn-default" ng-click="openEditView(entity.id)"><i className="fa fa-fw fa-pencil">EDIT</i></button>
                    <button type="button" className="btn btn-default" ng-click="deleteEntity(entity.id)"><i className="fa fa-fw fa-trash-o" style={{color:"red"}}>DELETE</i></button>
                  </div>
                </td>
              </tr>)}
            </tbody>
          </table>
        </div>
        <div className="DimeControlButtons">
          <button type="button" className="btn btn-primary" ng-click="createEntity()">Hinzufügen</button>
          <button type="button" className="btn btn-primary" ng-click="duplicateEntity()">Duplizieren</button>
          <button type="button" className="btn btn-default" onClick={this.reload}ng-click="reload(evict: true)"><span className="glyphicon glyphicon-refresh"></span></button>
        </div>
      </div>
    );
  }

}
