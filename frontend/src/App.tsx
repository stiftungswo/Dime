import * as React from 'react';
import './App.css';

import OfferOverview from './overview/OfferOverview';
import { inject, observer, Provider } from 'mobx-react';
import { OfferStore } from './store/offerStore';
import api from './store/api';

import { createBrowserHistory } from 'history';
import { Redirect, Route, RouteProps, Router, Switch } from 'react-router-dom';
import OfferDetailView from './overview/OfferDetailView';
import { EmployeeStore } from './store/employeeStore';
import { ServiceStore } from './store/serviceStore';
import Login from './employees/Login';
import { AuthStore } from './store/authStore';
import MuiThemeProvider from '@material-ui/core/styles/MuiThemeProvider';
import DimeTheme from './utilities/DimeTheme';
import DimeLayout from './utilities/DimeLayout';
import EmployeeOverview from './employees/EmployeeOverview';
import EmployeeUpdateView from './employees/EmployeeUpdateView';
import EmployeeCreateView from './employees/EmployeeCreateView';

const stores = {
  authStore: new AuthStore(api),
  offerStore: new OfferStore(api),
  employeeStore: new EmployeeStore(api),
  serviceStore: new ServiceStore(api),
};

const browserHistory = createBrowserHistory();

@inject('authStore')
@observer
class ProtectedRoute extends React.Component<RouteProps & { authStore?: AuthStore }> {
  protect = (props: any) => {
    const login = {
      pathname: '/login',
      state: { referrer: props.location.pathname },
    };
    const Component: any = this.props.component;
    return this.props.authStore!.isLoggedIn ? <Component {...props} /> : <Redirect to={login} />;
  };

  public render() {
    return <Route {...this.props} component={undefined} render={this.protect} />;
  }
}

class App extends React.Component {
  public render() {
    return (
      <Provider {...stores}>
        <MuiThemeProvider theme={DimeTheme}>
          <Router history={browserHistory}>
            <div className="App">
              <Switch>
                <Route exact path="/login" component={Login} />
                <DimeLayout>
                  <Switch>
                    <ProtectedRoute exact path="/" component={OfferOverview} />
                    <ProtectedRoute exact path="/offer/:id" component={OfferDetailView} />
                    <ProtectedRoute exact path="/employees" component={EmployeeOverview} />
                    <ProtectedRoute exact path="/employees/new" component={EmployeeCreateView} />
                    <ProtectedRoute exact path="/employees/:id" component={EmployeeUpdateView} />
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
