import * as React from 'react';
import { Link } from 'react-router-dom';

export default class UnstyledLink extends Link {
  constructor(props: any) {
    super(props);
  }

  public render() {
    return <Link style={{ textDecoration: 'none', color: 'white' }} {...this.props} />;
  }
}
