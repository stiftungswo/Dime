import * as React from 'react';
import './App.css';

import OfferOverview from './overview/OfferOverview';
import { Provider } from 'mobx-react';
import { OfferStore } from './store/offerStore';
import api from './api';

import { createBrowserHistory } from 'history';
import { Route, Router, Switch } from 'react-router-dom';
import OfferDetailView from './overview/OfferDetailView';
import { EmployeeStore } from './store/employeeStore';
import { ServiceStore } from './store/serviceStore';
import Login from './employees/Login';
import { AuthStore } from './store/authStore';
import MuiThemeProvider from '@material-ui/core/styles/MuiThemeProvider';
import DimeTheme from './utilities/DimeTheme';
import DimeLayout from './utilities/DimeLayout';
import EmployeeOverview from './employees/EmployeeOverview';

const stores = {
  authStore: new AuthStore(api),
  offerStore: new OfferStore(api),
  employeeStore: new EmployeeStore(api),
  serviceStore: new ServiceStore(api),
};

const browserHistory = createBrowserHistory();

class App extends React.Component {
  public render() {
    return (
      <Provider {...stores}>
        <MuiThemeProvider theme={DimeTheme}>
          <Router history={browserHistory}>
            <div className="App">
              <Switch>
                <Route exact={true} path="/login" component={Login} />
                <DimeLayout>
                  <Switch>
                    <Route exact={true} path="/" component={OfferOverview} />
                    <Route exact={true} path="/offer/:id" component={OfferDetailView} />
                    <Route exact={true} path="/employees" component={EmployeeOverview} />
                    <Route>
                      <p>404</p>
                    </Route>
                  </Switch>
                </DimeLayout>
              </Switch>
            </div>
          </Router>
        </MuiThemeProvider>
      </Provider>
    );
  }
}

export default App;
