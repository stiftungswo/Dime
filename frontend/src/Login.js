import React, { Component } from 'react';
import {fakeAuth} from "./App";
import {Redirect} from "react-router-dom";

export class Login extends Component{
  state = {
    redirectToReferrer: false,
    error: false,
    form: {
      name: "",
      password: ""
    }
  };

  login = (e) => {
    if(e){
      e.preventDefault();
    }
    fakeAuth.authenticate(this.state.form, (success) => {
      if(success){
        this.setState({ redirectToReferrer: true });
      } else {
        this.setState({ error: true });
      }
    });
  };

  changeField = (field, value)  => this.setState({
    form: {
      ...this.state.form,
      [field]: value
    }});
  changeText = (field) => (e) => this.changeField(field, e.target.value)

  render = () => {
    const { from } = this.props.location.state || { from: { pathname: "/" } };
    const { redirectToReferrer } = this.state;

    if (redirectToReferrer) {
      return <Redirect to={from} />;
    }

    return(
    <div ng-show="auth.showlogin">
      <div className="login-page">
        <div className="login-box">
          <div className="login-logo">
            DimeERP
          </div>

          <form className="login-box-body" onSubmit={this.login}>
            <p className="login-box-msg">Login</p>

            {this.state.error && <div className="alert alert-danger" role="alert" ng-if="loginFailed">Login fehlgeschlagen</div>}
            <div className="form-group has-feedback">
              <input value={this.state.form.name} onChange={this.changeText('name')} type="text" id="username" className="form-control" placeholder="Benutzername" ng-model="username" autoCorrect="off" autoCapitalize="off" spellCheck="false"/>
              <span className="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div className="form-group has-feedback">
              <input value={this.state.form.password} onChange={this.changeText('password')} type="password" id="password" className="form-control" placeholder="Passwort" ng-model="password"/>
              <span className="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div className="checkbox">
              <label>
                <input className="checkbox" type="checkbox" ng-model="rememberme"/> Angemeldet bleiben
              </label>
            </div>
            <div className="row">
              <div className="col-xs-8">
                &nbsp;
              </div>
              <div className="col-xs-4">
                <button type="submit" className="btn btn-primary btn-block btn-flat" onClick={this.login} ng-click="login()">
                  Login
                </button>
              </div>
            </div>

          </form>
        </div>
      </div>
    </div>
      )
  }
}