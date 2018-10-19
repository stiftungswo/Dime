import * as React from 'react';
import { Link, LinkProps } from 'react-router-dom';

const UnstyledLink = (props: LinkProps) => <Link style={{ textDecoration: 'none', color: 'white' }} {...props} />;
export default UnstyledLink;
