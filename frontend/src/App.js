import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import {Route, Link, HashRouter as Router, NavLink, Redirect} from "react-router-dom";
import {ServiceOverview} from "./ServiceOverview";
import {ServiceEdit} from "./ServiceEdit";
import {Login} from "./Login";
import {client, ServiceRepository} from "./api/api";

const Home = () => <div>Welcome Home.</div>

export const fakeAuth = {
  isAuthenticated: false,
  async authenticate({name, password}, cb) {
    client.defaults.auth = {
      username: name,
      password: password
    }
    try {
      await ServiceRepository.list()
      this.isAuthenticated = true;
      cb(true);
    } catch (e) {
      console.error(e);
      cb(false);
    }
  },
  signout(cb) {
    this.isAuthenticated = false;
    setTimeout(cb, 100);
  }
};

const PrivateRoute = ({ component: Component, ...rest }) => (
  <Route
    {...rest}
    render={props =>
      fakeAuth.isAuthenticated ? (
        <Component {...props} />
      ) : (
        <Redirect
          to={{
            pathname: "/login",
            state: { from: props.location }
          }}
        />
      )
    }
  />
);

class App extends Component {
  render() {
    return (
      <Router>
        <div className="App">
          <header className="App-header">
            <img src={logo} className="App-logo" alt="logo" />
            <h1 className="App-title">Welcome to React</h1>
          </header>
          <nav>
            <NavLink to={"/"}>Home</NavLink>
            /
            <NavLink to={"/services"}>Service Overview</NavLink>
          </nav>
          <div>
            <Route exact path={"/login"} component={Login}/>
            <PrivateRoute exact path={"/"} component={Home}/>
            <PrivateRoute exact path={"/services"} component={ServiceOverview}/>
            <PrivateRoute path={"/services/:id"} component={ServiceEdit}/>
          </div>
        </div>
      </Router>
    );
  }
}

export default App;
