import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import {Route, Link, HashRouter as Router, NavLink} from "react-router-dom";
import {ServiceOverview} from "./ServiceOverview";
import {ServiceEdit} from "./ServiceEdit";

const Home = () => <div>Welcome Home.</div>

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
            <Route exact path={"/"} component={Home}/>
            <Route exact path={"/services"} component={ServiceOverview}/>
            <Route path={"/services/:id"} component={ServiceEdit}/>
          </div>
        </div>
      </Router>
    );
  }
}

export default App;
