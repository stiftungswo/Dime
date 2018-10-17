import * as React from 'react';
import { Employee } from '../types';
import { inject, observer } from 'mobx-react';
import { EmployeeStore } from '../store/employeeStore';
import { RouteComponentProps } from 'react-router';
import { InjectedNotistackProps, withSnackbar } from 'notistack';
import EmployeeDetailView from './EmployeeDetailView';
import compose from '../compose';

interface EmployeeDetailRouterProps {
  id?: string;
}

export interface Props extends RouteComponentProps<EmployeeDetailRouterProps>, InjectedNotistackProps {
  employeeStore?: EmployeeStore;
}

@inject((stores: any) => ({
  employeeStore: stores.employeeStore as EmployeeStore,
}))
@observer
class EmployeeUpdateView extends React.Component<Props> {
  constructor(props: Props) {
    super(props);
    props.employeeStore!.fetchEmployee(Number(props.match.params.id));
  }

  public handleSubmit(employee: Employee) {
    this.props.employeeStore!
      .putEmployee(employee)
      .then(() => this.props.enqueueSnackbar('Mitarbeiter wurde erfolgreich aktualisiert.', { variant: 'success' }))
      .catch(() => this.props.enqueueSnackbar('Mitarbeiter konnte nicht gespeichert werden.', { variant: 'error' }));
  }

  public render() {
    const employee: Employee | undefined = this.props!.employeeStore!.employee;

    return <EmployeeDetailView handleSubmit={this.handleSubmit.bind(this)} employee={employee} />;
  }
}

export default compose(withSnackbar(EmployeeUpdateView));
