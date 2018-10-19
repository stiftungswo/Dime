import {observable} from "mobx";
import {Offer} from "../types";
import {Api} from "./api";

interface OfferListing{
    id: number;
    name: string;
    shortDescription: string
}

export class OfferStore{

    @observable public offers: OfferListing[] = []
    @observable public offer?: Offer = undefined;

    constructor(private api: Api){}

    public async fetchOffers(){
        const res = await this.api.client.get<OfferListing[]>('/offers')
        this.offers = res.data
    }

    public async fetchOffer(id: number){
        const res = await this.api.client.get<Offer>('/offers/' + id)
        this.offer = res.data;
    }
}