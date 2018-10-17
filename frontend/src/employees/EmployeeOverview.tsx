import * as React from 'react';
import { inject, observer } from 'mobx-react';
import Typography from '@material-ui/core/Typography/Typography';
import Button from '@material-ui/core/Button/Button';
import RefreshIcon from '@material-ui/icons/Refresh';
import AddIcon from '@material-ui/icons/Add';
import Grid from '@material-ui/core/Grid/Grid';
import Table from '@material-ui/core/Table/Table';
import TableHead from '@material-ui/core/TableHead/TableHead';
import TableRow from '@material-ui/core/TableRow/TableRow';
import TableCell from '@material-ui/core/TableCell/TableCell';
import TableBody from '@material-ui/core/TableBody/TableBody';
import { EmployeeStore } from '../store/employeeStore';
import { Employee } from '../types';
import FileCopyIcon from '@material-ui/icons/FileCopy';
import EditIcon from '@material-ui/icons/Edit';
import ArchiveIcon from '@material-ui/icons/Archive';
import DeleteIcon from '@material-ui/icons/Delete';

interface Props {
  employeeStore?: EmployeeStore;
}

@inject('employeeStore')
@observer
export default class EmployeeOverview extends React.Component<Props> {
  constructor(props: Props) {
    super(props);
    props.employeeStore!.fetchEmployees();
  }

  public render() {
    return (
      <Grid container={true} spacing={16}>
        <Grid item={true} xs={6}>
          <Typography component="h1" variant="h5" align={'left'}>
            Mitarbeiter
          </Typography>
        </Grid>

        <Grid item={true} xs={6}>
          <Button variant={'contained'} color={'primary'}>
            Hinzufügen
            <AddIcon />
          </Button>
          <Button variant="contained">
            Aktualisieren
            <RefreshIcon />
          </Button>
        </Grid>

        <Grid item={true} xs={12}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>Vorname</TableCell>
                <TableCell>Nachname</TableCell>
                <TableCell>E-Mail</TableCell>
                <TableCell>Login aktiviert</TableCell>
                <TableCell>Aktionen</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {this.props!.employeeStore!.employees.map((employee: Employee) => (
                <TableRow key={employee.id}>
                  <TableCell>{employee.first_name}</TableCell>
                  <TableCell>{employee.last_name}</TableCell>
                  <TableCell>{employee.email}</TableCell>
                  <TableCell>{employee.can_login ? 'Ja' : 'Nein'}</TableCell>
                  <TableCell>
                    <Button variant="text">
                      <FileCopyIcon />
                    </Button>
                    <Button variant={'text'}>
                      <EditIcon />
                    </Button>
                    <Button variant={'text'}>
                      <ArchiveIcon />
                    </Button>
                    <Button variant={'text'}>
                      <DeleteIcon />
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </Grid>
      </Grid>
    );
  }
}
