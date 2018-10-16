import { inject, observer } from 'mobx-react';
import * as React from 'react';
import { OfferStore } from '../store/offerStore';
import { Link } from 'react-router-dom';

export interface Props {
  offerStore?: OfferStore;
}

@inject('offerStore')
@observer
export default class OfferOverview extends React.Component<Props> {
  constructor(props: Props) {
    super(props);
    props.offerStore!.fetchOffers();
  }
  public render() {
    return (
      <ul>
        {this.props!.offerStore!.offers.length === 0 && <p>Keine Offerten.</p>}
        {this.props!.offerStore!.offers.map((offer: any) => (
          <li key={offer.id}>
            <Link to={`/offer/${offer.id}`}>
              <h3>{offer.name}</h3>
            </Link>
            <p>
              <i>{offer.shortDescription}</i>
            </p>
          </li>
        ))}
      </ul>
    );
  }
}
