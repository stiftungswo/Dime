import {observable} from "mobx";
import {Offer} from "../types";
import {MainStore} from "./mainStore";

interface OfferListing{
    id: number;
    name: string;
    shortDescription: string
}

export class OfferStore{

    @observable public offers: OfferListing[] = []
    @observable public offer?: Offer = undefined;

    constructor(private api: MainStore){}

    public async fetchOffers(){
        const res = await this.api.api.get<OfferListing[]>('/offers')
        this.offers = res.data
    }

    public async fetchOffer(id: number){
        const res = await this.api.api.get<Offer>('/offers/' + id)
        this.offer = res.data;
    }
}