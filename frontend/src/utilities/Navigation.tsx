import ListItem from '@material-ui/core/ListItem/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText/ListItemText';
import * as React from 'react';
import UnstyledLink from './UnstyledLink';

import PeopleIcon from '@material-ui/icons/People';
import DriveFile from '@material-ui/icons/InsertDriveFile';

interface NavItemProps {
  link: string;
  label: string;
  icon: any;
}

export const NavItem = ({ link, label, icon }: NavItemProps) => {
  const Icon = icon;

  return (
    <UnstyledLink to={link}>
      <ListItem button={true}>
        <ListItemIcon>
          <Icon />
        </ListItemIcon>
        <ListItemText primary={label} />
      </ListItem>
    </UnstyledLink>
  );
};

export const Navigation = () => (
  <React.Fragment>
    <NavItem link={'/'} label={'Offerten'} icon={DriveFile} />
    <NavItem link={'/employees'} label={'Mitarbeiter'} icon={PeopleIcon} />
  </React.Fragment>
);
