import { inject, observer } from 'mobx-react';
import * as React from 'react';
import Avatar from '@material-ui/core/Avatar';
import Button from '@material-ui/core/Button';
import CssBaseline from '@material-ui/core/CssBaseline';
import BeachAccessIcon from '@material-ui/icons/BeachAccess';
import Paper from '@material-ui/core/Paper';
import Typography from '@material-ui/core/Typography';
import createStyles from '@material-ui/core/styles/createStyles';
import withStyles, { WithStyles } from '@material-ui/core/styles/withStyles';
import * as yup from 'yup';
import { Field, Formik } from 'formik';
import { EmailFieldWithValidation, PasswordFieldWithValidation } from '../form/common';
import { AuthStore } from '../store/authStore';
import { RouteComponentProps, withRouter } from 'react-router';
import dimeTheme from '../utilities/DimeTheme';
import { Theme } from '@material-ui/core';
import { InjectedNotistackProps, withSnackbar } from 'notistack';
import compose from '../compose';

const loginSchema = yup.object({
  email: yup.string().required(),
  password: yup.string().required(),
});

const styles = ({ palette, spacing, breakpoints }: Theme) =>
  createStyles({
    layout: {
      width: 'auto',
      display: 'block', // Fix IE11 issue.
      marginLeft: spacing.unit * 3,
      marginRight: spacing.unit * 3,
      [breakpoints.up(400 + spacing.unit * 3 * 2)]: {
        width: 400,
        marginLeft: 'auto',
        marginRight: 'auto',
      },
    },
    paper: {
      marginTop: spacing.unit * 8,
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      padding: `${spacing.unit * 2}px ${spacing.unit * 3}px ${spacing.unit * 3}px`,
    },
    avatar: {
      margin: spacing.unit,
      color: '#fff',
      backgroundColor: palette.primary.main,
    },
    form: {
      width: '100%', // Fix IE11 issue.
      marginTop: spacing.unit,
    },
    submit: {
      marginTop: spacing.unit * 3,
      backgroundColor: palette.primary.main,
    },
  });

export interface Props extends RouteComponentProps, InjectedNotistackProps, WithStyles<typeof styles> {
  authStore?: AuthStore;
}

@inject((stores: any) => ({
  authStore: stores.authStore as AuthStore,
}))
@observer
class Login extends React.Component<Props> {
  constructor(props: any) {
    super(props);
  }

  public handleSubmit(values: { email: string; password: string }) {
    this.props.authStore!
      .postLogin({ ...values })
      .then(() => {
        this.props.history.replace('/');
      })
      .catch(e => this.props.enqueueSnackbar('Anmeldung fehlgeschlagen', { variant: 'error' }));
  }

  public render() {
    const { classes } = this.props;

    return (
      <React.Fragment>
        <CssBaseline />
        <main className={classes.layout}>
          <Paper className={classes.paper}>
            <Avatar className={classes.avatar}>
              <BeachAccessIcon />
            </Avatar>
            <Typography component="h1" variant="h5">
              Dime-Anmeldung
            </Typography>
            <Formik
              validationSchema={loginSchema}
              initialValues={{
                email: '',
                password: '',
              }}
              onSubmit={values => this.handleSubmit(values)}
              render={props => (
                <form className={classes.form} onSubmit={props.handleSubmit}>
                  <Field component={EmailFieldWithValidation} name="email" label="E-Mail" fullWidth={true} />
                  <Field component={PasswordFieldWithValidation} name="password" label="Passwort" fullWidth={true} />
                  <Button
                    type="submit"
                    disabled={props.isSubmitting}
                    fullWidth={true}
                    variant="contained"
                    color="primary"
                    className={classes.submit}
                    onClick={() => props.handleSubmit()}
                  >
                    Anmelden
                  </Button>
                </form>
              )}
            />
          </Paper>
        </main>
      </React.Fragment>
    );
  }
}

export default compose(withStyles(styles(dimeTheme)), withSnackbar, withRouter)(Login);
