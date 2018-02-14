import React, { Component } from 'react';

const TODO = () => <div>TODO</div>;
const RateOverview = TODO;
const PercentageInput = TODO;

export class ServiceEdit extends Component{
  constructor(props){
    super(props);
    this.state = {
      name: "Foo",
      alias: "foo",
      description: "Foo is a placeholder word.",
      vat: 0.077,
      chargeable: false,
      archived: true
    }
  }

  changeText = (field) => (e) => this.setState({[field]: e.target.value})
  changeCheckbox = (field) => (e) => this.setState({[field]: e.target.checked})

  render = () => {
    return (
      <div>
      <div className="box box-primary">
        <div className="box-header with-border">
          <h3 className="box-title">Service bearbeiten</h3>
        </div>
        <div className="box-body" name="editform">
          <div className="form-horizontal">
            <div className="form-group">
              <div className="form-group">
                <label className="col-sm-2 control-label">Name</label>
                <div className="col-sm-4">
                  <input style={{width: "100%"}} className="form-control" type="text" value={this.state.name} onChange={this.changeText('name')}/>
                </div>
              </div>
              <div className="form-group">
                <label className="col-sm-2 control-label">Alias</label>
                <div className="col-sm-4">
                  <input style={{width: "100%"}} className="form-control" type="text" value={this.state.alias} onChange={this.changeText('alias')}/>
                </div>
              </div>
              <div className="form-group">
                <label className="col-sm-2 control-label">Beschreibung</label>
                <div className="col-sm-4">
                  <input style={{width: "100%"}} className="form-control" type="text" value={this.state.description} onChange={this.changeText('description')}/>
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
                      <input type="checkbox" value={this.state.chargeable} onChange={this.changeCheckbox('chargeable')}/> Verrechenbar
                    </label>
                  </div>
                </div>
              </div>
              <div className="form-group">
                <div className="col-sm-offset-2 col-sm-4">
                  <div className="checkbox">
                    <label>
                      <input type="checkbox" value={this.state.archived} onChange={this.changeCheckbox('archived')}/> Archiviert
                        <div className="text-muted">Wenn ein Service archiviert ist, kann er nicht mehr zu Projekten hinzugefügt werden.</div>
                    </label>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    <RateOverview/>
    <div className="DimeControlButtons">
      <button type="button" className="btn btn-primary" ng-click="saveEntity()">SAVE</button>
      <button type="button" className="btn btn-default" ng-click="reload(evict: true)"><span className="glyphicon glyphicon-refresh">REFRESH</span></button>
    </div>
    </div>
  );
  }

}
