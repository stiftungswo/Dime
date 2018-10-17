import ListItem from '@material-ui/core/ListItem/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText/ListItemText';
import * as React from 'react';
import UnstyledLink from './UnstyledLink';

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
