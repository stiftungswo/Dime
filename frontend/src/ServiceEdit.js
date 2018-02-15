import React, { Component } from 'react';
import {client, ServiceRepository} from "./api/api";

const TODO = () => <div>TODO</div>;
const RateOverview = TODO;
const PercentageInput = TODO;

export class ServiceEdit extends Component{
  constructor(props){
    super(props);
    this.state = {
      service: null,
      changed: []
    }
  }

  componentWillMount = () => this.refresh();

  refresh = async () => {
    const service = await ServiceRepository.one(this.props.match.params.id);
    this.setState({service})
  }

  save = async () => {
    const entity = {}
    this.state.changed.forEach(field => entity[field] = this.state.service[field]);
    console.log(entity);

    await ServiceRepository.save(entity, {id: this.state.service.id})
    this.refresh();
  }

  changeService = (field, value)  => this.setState({
    service: {
      ...this.state.service,
      [field]: value
    },
    changed: [
      ...this.state.changed,
      field
    ] //FIXME values should be unique here
  })

  changeText = (field) => (e) => this.changeService(field, e.target.value)
  changeCheckbox = (field) => (e) => this.changeService(field, e.target.checked)

  render = () => {
    const service = this.state.service;

    return (
      <div>
      <div className="box box-primary">
        <div className="box-header with-border">
          <h3 className="box-title">Service bearbeiten</h3>
        </div>
        {
          this.state.service ?
            <div className="box-body" name="editform">
              <div className="form-horizontal">
                <div className="form-group">
                  <div className="form-group">
                    <label className="col-sm-2 control-label">Name</label>
                    <div className="col-sm-4">
                      <input style={{width: "100%"}} className="form-control" type="text" value={service.name} onChange={this.changeText('name')}/>
                    </div>
                  </div>
                  <div className="form-group">
                    <label className="col-sm-2 control-label">Alias</label>
                    <div className="col-sm-4">
                      <input style={{width: "100%"}} className="form-control" type="text" value={service.alias} onChange={this.changeText('alias')}/>
                    </div>
                  </div>
                  <div className="form-group">
                    <label className="col-sm-2 control-label">Beschreibung</label>
                    <div className="col-sm-4">
                      <input style={{width: "100%"}} className="form-control" type="text" value={service.description} onChange={this.changeText('description')}/>
                    </div>
                  </div>
                  <div className="form-group">
                    <label className="col-sm-2 control-label">MwSt</label>
                    {/* <input-percentage className="col-sm-4" htmlclass="'form-control'" value="entity.vat" ng-change="addSaveField('vat')"></input-percentage> */}
                    <PercentageInput/>
                  </div>
                  <div className="form-group">
                    <div className="col-sm-offset-2 col-sm-4">
                      <div className="checkbox">
                        <label>
                          <input type="checkbox" checked={service.chargeable} onChange={this.changeCheckbox('chargeable')}/> Verrechenbar
                        </label>
                      </div>
                    </div>
                  </div>
                  <div className="form-group">
                    <div className="col-sm-offset-2 col-sm-4">
                      <div className="checkbox">
                        <label>
                          <input type="checkbox" checked={service.archived} onChange={this.changeCheckbox('archived')}/> Archiviert
                          <div className="text-muted">Wenn ein Service archiviert ist, kann er nicht mehr zu Projekten hinzugefügt werden.</div>
                        </label>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            :
            <div>...</div>
        }
      </div>
    <RateOverview/>
    <div className="DimeControlButtons">
      <button type="button" className="btn btn-primary" onClick={this.save} ng-click="saveEntity()">SAVE</button>
      <button type="button" className="btn btn-default" onClick={this.refresh} ng-click="reload(evict: true)"><span className="glyphicon glyphicon-refresh">REFRESH</span></button>
    </div>
    </div>
  );
  }

}