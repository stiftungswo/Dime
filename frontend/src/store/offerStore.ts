import {observable} from "mobx";
import {AxiosInstance} from "axios";
import {Offer} from "../types";

interface OfferListing{
    id: number;
    name: string;
    shortDescription: string
}

export class OfferStore{

    @observable public offers: OfferListing[] = []
    @observable public offer?: Offer = undefined;

    constructor(private api: AxiosInstance){}

    public async fetchOffers(){
        const res = await this.api.get<OfferListing[]>('/offers')
        this.offers = res.data
    }

    public async fetchOffer(id: number){
        const res = await this.api.get<Offer>('/offers/' + id)
        this.offer = res.data;
    }
}