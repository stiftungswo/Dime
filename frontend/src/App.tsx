import * as React from 'react';
import './App.css';

import logo from './logo.svg';
import OfferOverview from './overview/OfferOverview';
import { Provider } from 'mobx-react';
import { OfferStore } from './store/offerStore';
import { api } from './api';

import { createBrowserHistory } from 'history';
import { Router, Switch, Route } from 'react-router-dom';
import OfferDetailView from './overview/OfferDetailView';
import { EmployeeStore } from './store/employeeStore';
import { ServiceStore } from './store/serviceStore';

const stores = {
  offerStore: new OfferStore(api()),
  employeeStore: new EmployeeStore(api()),
  serviceStore: new ServiceStore(api()),
};

const browserHistory = createBrowserHistory();

class App extends React.Component {
  public render() {
    return (
      <Provider {...stores}>
        <Router history={browserHistory}>
          <div className="App">
            <header className="App-header">
              <img src={logo} className="App-logo" alt="logo" />
              <h1 className="App-title">Welcome to Dime</h1>
            </header>
            <Switch>
              <Route exact path="/" component={OfferOverview} />
              <Route exact path="/offer/:id" component={OfferDetailView} />
              <Route>
                <p>404</p>
              </Route>
            </Switch>
          </div>
        </Router>
      </Provider>
    );
  }
}

export default App;
