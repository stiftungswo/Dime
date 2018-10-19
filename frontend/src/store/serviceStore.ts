import {observable} from "mobx";
import {Service} from "../types";
import {Api} from "./api"

interface ServiceListing{
    id: number;
    name: string;
    shortDescription: string
}

export class ServiceStore{

    @observable public services: ServiceListing[] = []
    @observable public service?: Service = undefined;

    constructor(private api: Api){}

    public async fetchServices(){
        const res = await this.api.client.get<ServiceListing[]>('/services')
        this.services = res.data
    }

    public async fetchService(id: number){
        const res = await this.api.client.get<Service>('/services/' + id)
        this.service = res.data;
    }
}