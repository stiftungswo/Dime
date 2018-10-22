import * as React from 'react';
import CssBaseline from '@material-ui/core/CssBaseline/CssBaseline';
import AppBar from '@material-ui/core/AppBar/AppBar';
import { Button, CircularProgress, Theme, WithStyles } from '@material-ui/core';
import createStyles from '@material-ui/core/styles/createStyles';
import DimeTheme from './DimeTheme';
import withStyles from '@material-ui/core/styles/withStyles';
import classNames from 'classnames';
import Toolbar from '@material-ui/core/Toolbar/Toolbar';
import IconButton from '@material-ui/core/IconButton/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import Typography from '@material-ui/core/Typography/Typography';
import Drawer from '@material-ui/core/Drawer/Drawer';
import ChevronLeftIcon from '@material-ui/icons/ChevronLeft';
import Divider from '@material-ui/core/Divider/Divider';
import Paper from '@material-ui/core/Paper/Paper';
import { Navigation } from './Navigation';
import compose from '../compose';
import { inject, observer } from 'mobx-react';
import { MainStore } from '../store/mainStore';

const drawerWidth = 240;

const styles = ({ palette, spacing, breakpoints, mixins, transitions, zIndex }: Theme) =>
  createStyles({
    root: {
      display: 'flex',
    },
    toolbar: {
      paddingRight: 24, // keep right padding when drawer closed
    },
    toolbarIcon: {
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'flex-end',
      padding: '0 8px',
      ...mixins.toolbar,
    },
    appBar: {
      zIndex: zIndex.drawer + 1,
      transition: transitions.create(['width', 'margin'], {
        easing: transitions.easing.sharp,
        duration: transitions.duration.leavingScreen,
      }),
    },
    appBarShift: {
      marginLeft: drawerWidth,
      width: `calc(100% - ${drawerWidth}px)`,
      transition: transitions.create(['width', 'margin'], {
        easing: transitions.easing.sharp,
        duration: transitions.duration.enteringScreen,
      }),
    },
    menuButton: {
      marginLeft: 12,
      marginRight: 36,
    },
    menuButtonHidden: {
      display: 'none',
    },
    title: {
      flexGrow: 1,
    },
    drawerPaper: {
      position: 'relative',
      whiteSpace: 'nowrap',
      width: drawerWidth,
      transition: transitions.create('width', {
        easing: transitions.easing.sharp,
        duration: transitions.duration.enteringScreen,
      }),
    },
    drawerPaperClose: {
      overflowX: 'hidden',
      transition: transitions.create('width', {
        easing: transitions.easing.sharp,
        duration: transitions.duration.leavingScreen,
      }),
      width: spacing.unit * 7,
      [breakpoints.up('sm')]: {
        width: spacing.unit * 9,
      },
    },
    appBarSpacer: mixins.toolbar,
    content: {
      flexGrow: 1,
      padding: spacing.unit * 3,
      height: '100vh',
      overflow: 'auto',
    },
    chartContainer: {
      marginLeft: -22,
    },
    tableContainer: {
      height: 320,
    },
    h5: {
      marginBottom: spacing.unit * 2,
    },
    mainContent: {
      overflowX: 'auto',
      textAlign: 'left',
      padding: spacing.unit * 2,
    },
    progress: {
      margin: spacing.unit * 2,
    },
  });

interface Props extends WithStyles<typeof styles> {
  children?: React.ReactNode;
  mainStore?: MainStore;
}

@inject('mainStore')
@observer
class DimeLayout extends React.Component<Props> {
  public state = {
    open: false,
  };

  public handleDrawerOpen = () => {
    this.setState({ open: true });
  };

  public handleDrawerClose = () => {
    this.setState({ open: false });
  };

  public render() {
    const { children, classes } = this.props;

    return (
      <React.Fragment>
        <CssBaseline />
        <div className={classes.root}>
          <AppBar position={'absolute'} className={classNames(classes.appBar, this.state.open && classes.appBarShift)}>
            <Toolbar disableGutters={!this.state.open} className={classes.toolbar}>
              <IconButton
                color={'inherit'}
                aria-label={'Menü öffnen'}
                onClick={this.handleDrawerOpen}
                className={classNames(classes.menuButton, this.state.open && classes.menuButtonHidden)}
              >
                <MenuIcon />
              </IconButton>

              <Typography component={'h1'} variant={'h6'} color={'inherit'} noWrap={true} className={classes.title} align={'left'}>
                Dime
              </Typography>

              {this.props.mainStore!.loading && (
                <Button>
                  <CircularProgress className={classes.progress} color="secondary" size={16} />
                </Button>
              )}
            </Toolbar>
          </AppBar>

          <Drawer
            variant={'permanent'}
            classes={{ paper: classNames(classes.drawerPaper, !this.state.open && classes.drawerPaperClose) }}
            open={this.state.open}
          >
            <div className={classes.toolbarIcon}>
              <IconButton onClick={this.handleDrawerClose}>
                <ChevronLeftIcon />
              </IconButton>
            </div>

            <Divider />

            <Navigation />
          </Drawer>

          <main className={classes.content}>
            <div className={classes.appBarSpacer} />
            <Paper className={classes.mainContent}>{children}</Paper>
          </main>
        </div>
      </React.Fragment>
    );
  }
}

export default compose(withStyles(styles(DimeTheme)))(DimeLayout);
